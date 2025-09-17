Return-Path: <linux-kernel+bounces-820858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D19B7F7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CF33B2918
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F931A81C;
	Wed, 17 Sep 2025 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eNrKgr6H"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F212F260C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116394; cv=none; b=TfywYcjIK7cC8Egve8e0UKg95hhdWM1Br3v/ODIMrGyr9dXr/9j4hq+JYunWhCdzpTIIwyUDZ77DfPdOE+ZT7njt2iYvSKxNyY23LojTzTVEUGjutkZaMLudCUVGYTUIHpUc9azR3DrlyUyNQFtL2jpHXvDt1eLyEMzCQWcocD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116394; c=relaxed/simple;
	bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3cYwFmVHaM7W/eHSlCDqUOuryMBsMNu2tohazQLanVMOELr3Oz10aUmAX8OF+cbAmiENRUCq22aOLyyEnzlGwUKYbGTE4wjwY1iQl+x0eT9I8EdrpPIpd0YW6D2IrRqBo2EYEW3pDu9zZk1N+EUtS5TpDXwC13u8O2DCJMkeCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eNrKgr6H; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b04770a25f2so932675966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758116390; x=1758721190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
        b=eNrKgr6HCQwQDC+GJgTjsluPKiV+A5hlNfqMKzhdYFBYDlFzX0PK5F2q64pQsT4J6W
         HTPma8M2FVFigPOQKFureNFyDWaNg1XubtMXMWWs8b+d8+AJGYXvkPCChf4xb3HyUOIs
         qoeVRGe9DxZiub5qMDNqQ5TUKgciXbDHlO7uM6Q6uZ05CvjtDg8308qjWFHCI9ZAJxye
         hvdsH2AVsq+TAMpKbjp31hu/0wsu0wOh2QVpdcyWU6elak//eb/TY+cEmZtNHLxUBCLB
         oB4BiWjcfoydBDkjL7x/9XrD5vxL2UI5ByyOcjOMv5uXWqHnD0SUYMWkWWWyQg2hGWOy
         ycIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116390; x=1758721190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
        b=mdAQqPaDtpe7Ols+zApP1qUVYqDTcn5o5dQLyPV9kQiy/SBlSI1j/5mrOeuWxeJd1V
         FTSgI6V67A/DjF6OAnFMtQDouNy71H0Nc8jpDlgynlxP/wBRYivyeDCk0SGBqHliFEKL
         ASZl/TGMZPk2M5ogwtKFzn82Vk3YM+geXFrjL030M6oa25PKIOCRlq1iwjTWdDfm1mLI
         pi6MdwOsDnWhycGUza1gq9/Np7aKbcz/yWQFfd5wt6VuXGnDIXiqVjbvhdxG3xwkyxKR
         Xtbhqp9Un1gbFrYO0TnR14L/PvfHPbIpdRx7MTr/WPM/F8wVIXxy+rJCUhwD3q4hiDfp
         QfqA==
X-Forwarded-Encrypted: i=1; AJvYcCWc5Pfug6GFmAiVooDgndGFLHR2cc6lk91PE7txw3WP2g3tj/3XI5kswxp20CwR3lFtx92pyHKczqHBP7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61bvzxvyz8eITiDshdbvk7SgIlmjMNOzB+a0ncE9FfOt08Bi+
	XZAUmDP7frkK7M8ax99DObg8Iy/oiPzETdsXHIjrlYmS5u9vccNcabOpYFCd48lOWsHgvt61JeA
	Qg2d5g16LcS7/esnZGmXRsHXOCLLJZXrRULXW2DZYlYwlTeceKw+d
X-Gm-Gg: ASbGncsQEq4XCRp2pRj/QchtZ7nRdNl2nN//GWGUbMyL6NCZfXoroUDWcnKw+Yhhmrv
	g9hFRfyKeCNUUon7AEvg3e5t8egn9nuDYqqjSGmi6YsSeFO8hJtUBEQducx+PqmEFSMI2WbgkKs
	TvLj88S/M0DxVx+geGyYi9dDr/o+FwWLoK9exTY973zv+jQMN/RcImXhAllkcAGDfgr8fLmhheZ
	OgA1feYAJAxWmwNaXsnkMk6lbuTCXNf10Lp
X-Google-Smtp-Source: AGHT+IGqqKefXP8WxcN/+l1jwy9unDcdcYQ+LOIaW5Cks3BIj9V+aI0trws7o6JbFaSx8xHpY7sjGGzFBBSJONjxZms=
X-Received: by 2002:a17:907:9687:b0:aff:9906:e452 with SMTP id
 a640c23a62f3a-b1bbb0678f2mr302885666b.31.1758116390548; Wed, 17 Sep 2025
 06:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
In-Reply-To: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 15:39:39 +0200
X-Gm-Features: AS18NWCdr6GqUOQd4v8IrrCyA7jXtDhoQx-mp5NUMtPzl5TNlq5K2XQ23QjAEV8
Message-ID: <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> Does the patch convert literally all iput calls within ceph into the
> async variant? I would be worried that mandatory deferral of literally
> all final iputs may be a regression from perf standpoint.

(Forgot to reply to this part)
No, I changed just the ones that are called from Writeback+Messenger.

I don't think this affects performance at all. It almost never happens
that the last reference gets dropped by somebody other than dcache
(which only happens under memory pressure).
It was very difficult to reproduce this bug:
- "echo 2 >drop_caches" in a loop
- a kernel patch that adds msleep() to several functions
- another kernel patch that allows me to disconnect the Ceph server via ioc=
tl
The latter was to free inode references that are held by Ceph caps.
For this deadlock to occur, all references other than
writeback/messenger must be gone already.
(It did happen on our production servers, crashing all of them a few
days ago causing a major service outage, but apparently in all these
years we're the first ones to observe this deadlock bug.)

(I don't know the iput() ordering on umount/shutdown - that might be
worth a closer look.)

