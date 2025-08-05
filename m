Return-Path: <linux-kernel+bounces-756755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921B9B1B8DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9380F16BB8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628229552B;
	Tue,  5 Aug 2025 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="GCAyi8l3"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA1294A0B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412935; cv=none; b=kjHLCcE+2O7xlnDdu/l2h9UyVHiAbR/hwK4G1Or1HptFv9tCqi9AWhGjaA8OwAHEKRI9QimNpqcbPooI01SyB6tcRa4Nhte8vbEUooMcz+CNdyp6u/rnqjTW1WD4pa9T2MBmesATSOtWLDWFIwGDXrlII404CAhoyZwSyPXniNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412935; c=relaxed/simple;
	bh=Fp5HWiT4EbVZep/x9cvBV1E7HldqS1NmMje5M8EiILI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LCrC0JSgg3ebyDWUAZEPbZ3M1lqbIUwFjKJBSD4wWWGQGcke/yvBF0SEqq2cnxglURQTVZHYUWGFrgFUQLzZndFqKwqJjSROy55BeUzL57xtfquhyeVkHBFEJL7rxvwYosCNLzyITEBJ73UCsb2tiag3AEZPHwmeNnp+z0z5BLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=GCAyi8l3; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b170c99aa49so3806634a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1754412933; x=1755017733; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wkz91KHprB6isKf23cxufh6A8qop4qxhhEsx0NJGcM=;
        b=GCAyi8l3iVyWYbEU2ealgxNkQcsYBhVYo/UrfwnEowwrCJe+ur7TvplvasSFLa2Jh8
         5a9/pADFupQ/NmdyY7eMuGnt4RqZg9/nhHVYmj+UCTf4d9f8OBQfRurQHukaknOQ8vsM
         0l5inrMCKVKcj7WZodb8sGAAIUMz8ZVFcTFUjR4lNl3EBJlCn3f7tzw4fYNDlHGc3GhV
         Z4LHuQHxrjyZ4ZrLK0UkPpHx3GbOsIn4A1FZ7TtAKX/8pFTKHGxK9CefqXc4SFky0QlD
         tFroCHnBjt84uJP+9MUWe9aj1MdcllXEnPYMGdijYk3NOMYAzMwscbtADjt3FrTtE4dt
         Mpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412933; x=1755017733;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1wkz91KHprB6isKf23cxufh6A8qop4qxhhEsx0NJGcM=;
        b=iw4/2+y9V+DZ5fMd+GokcHwarAw8a59NZlvgFx5TJdgfWyLP/sMAjF44Vyv8UM8XP/
         Rd4WIKK4Y1799vi759ZymN/F8F04pZ7sSA1AjzEzGj+VudtSvlEBtn9k2WgGlh8dXDTE
         z7os06bTI1jTSrhK5r7Az9lQgTN60JhvaX5bWgAf5t7pLKBIGcjgAeLyOj8KbMD2tUvT
         0XrzeGQCiemutxXS4U33a5ZpKBE8ughpUCoCZ1JsI2WqqIC9Wno7ZhjOYvxKHfAz0L7d
         NXm43mEECirYOZUyb6vbACqPheoH5I09uNTymh67IRet711BB6HtpX7ZIMak/Y7ubkr8
         H4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVEVYmYa7PlxAR3MBfAzVUHDalTo02OYUWTf9UG0832KmbPkWnPRYwsRdNb81D2EnJZRV12qos6AHKx/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyoXopjbNwuWd71ErG/oDd8tr85VRW6VzahT+Lrq7d0o/5AN0d
	4sXt/I3q/3INchHNosa4nk8dASfk1iMowVJXIMnqcsS1O6EmAJZhkWMwlA89MfoBq/k=
X-Gm-Gg: ASbGncsIMw1aVZexinDp83X9ulEMdHwJPHE56uuze3BhebqdpajstcfyF0A81LRfFNB
	ClrLe4smoPcU22tnNWDBD7T9XnFCUkGgsCBX1xhb3xtTwPF3GYzwMBJhVb5spBPOH//R3nIR0HT
	ftHOaxvXPjY9nXC2IP6qFuP1CdFUQqGAGZQkeGx0XreeI6KfVTDzkDWW66+ga/NYhRlFyznlRzw
	RX8jMSFGTZIu5uzZWqC/b9Rc3LFDvARCsDi8oH7gfL1zkntlb1rr7yei4Te8DmV5lv5dWZEgRxJ
	yW/RASeYMW21x/kk8q+IqIn2Sycm0Gezrc5YvRYZvwGUOMLLDgUNPjtz9IdELeh7fkwEX8LXvtC
	Jx7bzphKfhWxs09V5G/U=
X-Google-Smtp-Source: AGHT+IGAfhYUa7PhuRsJVXdjeXsZjVW5MeNg35FqZ+gfJ661zQM8GUygCqYfQ1PuCGyCdesm2o1qQw==
X-Received: by 2002:a17:903:2f87:b0:23f:cf96:3071 with SMTP id d9443c01a7336-24247033f3dmr220933225ad.49.1754412932893;
        Tue, 05 Aug 2025 09:55:32 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaf855sm138621195ad.168.2025.08.05.09.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 09:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Aug 2025 10:55:30 -0600
Message-Id: <DBUNH9S9HCXH.SIOBPAT3U91N@brighamcampbell.com>
Cc: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] drm: Add directive to format code in comment
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Giant Sand Fans" <rampxxxx@gmail.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250804212902.22554-1-rampxxxx@gmail.com>
 <qf6xwtxh57jg6ico7n53ft7bepogeal5wfhthodsnf55eabgum@de2ah47jovbg>
 <CABPJ0vgz6gib5LdKY1O6uhPq7Tk5GN2X_dcGBwtx3b=TRQUw-Q@mail.gmail.com>
In-Reply-To: <CABPJ0vgz6gib5LdKY1O6uhPq7Tk5GN2X_dcGBwtx3b=TRQUw-Q@mail.gmail.com>

On Tue Aug 5, 2025 at 5:53 AM MDT, Giant Sand Fans wrote:
> On Tue, 5 Aug 2025 at 12:49, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>> Fixes tag?
>    Sorry, what do you mean?

Dmitry is looking for a tag in the body of your patch (much like your
"Signed-off-by" tag) which describes the commit which introduced the bad
behavior[1]. In this case, it looks like this block was introduced with
the incorrect kerneldoc code block formatting by commit 471920ce25d5, so
the correct Fixes tag would look like the following:

Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")

[1]: https://docs.kernel.org/process/submitting-patches.html#using-reported=
-by-tested-by-reviewed-by-suggested-by-and-fixes

Cheers,
Brigham

