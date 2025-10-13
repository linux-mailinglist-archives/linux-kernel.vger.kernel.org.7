Return-Path: <linux-kernel+bounces-850680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71333BD381E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E56C04F6106
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC1021E0AD;
	Mon, 13 Oct 2025 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag9qtn8W"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092412B94
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365380; cv=none; b=ENr/4uHsD2J8r2jhQStnM7+czn/U9yEIk1KUwydw3MEgxNrO4pogN/g6MSL59978nB3fcJpTbJ3Im309QkxRjvQ2athR0cTXENe2sTaRdneI5QYNxEqsb4UJ1h7mCGOTOCjiEA0KXnc8qyqkXjFzDkwTwUOPzOQnizTdAQ8c53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365380; c=relaxed/simple;
	bh=nQDmLmpvt7xyeehMRRFgwseVV7xUEOIemq4RQrq5AnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaJ9gmv52iXe3eM3TOEMkTKPO1QTKdmdwStSKnG6Oz0i0vxwJchirJoO3A+0yhE6womVEisvYU7fPTPJX6Yemo3y4lYg50blx3kQI2W1yB27c86gChgGPkyD6JwHbIBNCQILmvQbvqQofA+wjchBNE27C3pvMQaX4CmWp9R/CPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ag9qtn8W; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63cf0638c1dso2721502d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760365377; x=1760970177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nQDmLmpvt7xyeehMRRFgwseVV7xUEOIemq4RQrq5AnE=;
        b=Ag9qtn8W4fslTnElCtGltToF7anhvxIJvcsydXTMixHA29cfY2Yf0iPUQO1wtxUpzR
         nWpUIMxtpehGRbZzWAH78E+VZtzm3Ap2GlEA2NnTlZvUVnyAtJDkbmNPPZ9/8o9wtnEy
         M2tMH7kk1+NAvfiZoIQcP85zFRIRkgMIqbPK0vLE5m0rzCkNYpcGpXaN6aTVi5rTFJDf
         02MlzVILOGtrWMK3nAfue1JR1+IRXa8PLA5z8HpFQNj0wczwL+MlynIiv8Wf0WWi8hMl
         MNdY5Hh52qi7H8e6QP9YjTBuTnOdGOJD5OJpGhhxN1148qqX5kfCydpWu6RgLq5qV4GJ
         2aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760365377; x=1760970177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQDmLmpvt7xyeehMRRFgwseVV7xUEOIemq4RQrq5AnE=;
        b=A8yLTQVJZ04rjSVvEg1/xufvfC6+ftR4ap0hXGi4GiwjuYf/CaL1oLQ9cP0f0ipg9t
         yqigU1XhTD/hSyBsXb2ccLXQxTT/7zFfp/9ToLsbFx+FKWASTsiVMgRv5fzfOsEubQBK
         aNvFmKc0W9Fe+AHr1PFndCVxm+oYK1tVRPFVEwcN7L3VHF0hteGggHCvJDjmcOv/SBcg
         lLfp0vIjDB5Pr9oGpiWa5fBd0ePs2JlmNOp5mUT+JCKl5gdroFT6FbNxcOwBZtOb8Kg9
         dwv0EGiSt0uop65RcPiyo0h8EvtnybAMPutSsgcjNI5MKROHHiLAZ6gHIYc2QnFGuGcO
         EnpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdmocRWOLXOZ+L7yFC5ZwwC966o2rutrXR1sHoKeob8ySkWHL5z/Ot8BdsfPdFWYx9jkSqNl+K04xqjDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ4jCARwX3SIdHab6IddYIs1WFHY7CeZjkXo4e9gSbBR9MrkOe
	161KgktBa0AHu+dCj1sTmnI5CFILJZ5GsTpQmF2wcT5dNiTB7vl6jMGeo+AZes8+1uF3oPzu6cG
	jKkuI2viONxmZ/HBmviWvzDM76i6NKcM=
X-Gm-Gg: ASbGncvSCsOrF9yM/CYZyUdaBhRnL5s0ogVa7Faem8pp0Qs5K8WG6FQTIebAdcFmQXd
	kcVwysxrv1wF3vdICE7s5vOKMWCdcXAbA4cf2X9kuaGE1tMcgejnzNiXrzCt1jJ5Mma2R/zYwbr
	oerzYzLKslsJqLILHYOdxNVc6divzCVJ9rmZRTtviFrG2cmEe98qPt5vBqmK6gelHt4LyQyAhMq
	DnRX2TEnEJkIRULThes7PnUs/x9eWGzDUtvBZpxFMSvnVK0idtCBaXT8OftqrXKw5NDfXeXTRU1
	WgP7WIGzdEAEwAQmCOI1Fok6zg==
X-Google-Smtp-Source: AGHT+IFw3m5r5B57PTPTqjIZPVu/VeImTsLrIGOLmdDTjH42dwQ/oEcjzZqblWVNhJBiQlGGV3aa/bbrC//1J8fxHRQ=
X-Received: by 2002:a05:690e:c4a:b0:63c:f5a6:f302 with SMTP id
 956f58d0204a3-63cf5a707e3mr8298400d50.68.1760365377470; Mon, 13 Oct 2025
 07:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013093337.4432-1-kartikey406@gmail.com> <bab3249a-d9f2-4f19-9493-b7560aecc3ce@redhat.com>
 <aOz6wqdZcEY8-ufB@localhost.localdomain>
In-Reply-To: <aOz6wqdZcEY8-ufB@localhost.localdomain>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 13 Oct 2025 19:52:45 +0530
X-Gm-Features: AS18NWBUkYtvmMzc5cc_0q9l-c8KMySPiyoca6hPI3y-2obBhc_-nDf-RcT0WDE
Message-ID: <CADhLXY6wvugZN+_ok8LnwWjUP8CWB4ETKtD6Er7y1thnJXwFFA@mail.gmail.com>
Subject: Re: [PATCH v4] hugetlbfs: check for shareable lock before calling huge_pmd_unshare()
To: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>, muchun.song@linux.dev, akpm@linux-foundation.org, 
	broonie@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Oscar and David,

Since I've been working through the iterations on this fix, would it be
okay if I send v5 with David's suggested change? I'd like to see this
through to completion.

Thanks,
Deepanshu

