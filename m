Return-Path: <linux-kernel+bounces-851398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A004BD65AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15F64345227
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F862EA17B;
	Mon, 13 Oct 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmlrZ1LE"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785C2D837B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390982; cv=none; b=UyWus1Nq1DHXISDiXXkKHYsxBzE3srZBfB1Sa24AdrV/h9RQaVlhNJ4JapEi+gh4UeAIPGyoKxmnzCTn6iKW3MnXk56jv8XWGxzNkVZQX9uooyXzhjJfuU6KHmcA988ouDg442jaCK95rGqZeHWH+5DxD9N/LPtFS6qVD/TN8AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390982; c=relaxed/simple;
	bh=L3DZEUMthZ72yWm4dpNL1BuO1jf/LiwENYsVfYFzkZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InWJGTcgm+AOGv0TDNwJrM88rdEND9p5nXDmyPR3IRFRoyUSrTA449UbO3jaETelEazHhlSZ81hARNSeCiL5EODw4gaf2y44jBeHJwZZQaJOFjg1erBwoJQo+5ZE62CDOefAlWw6hGhvJ6/BeYlTkFMoQd42NF7S3F4Abo2qrg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmlrZ1LE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b554bb615dcso3141557a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760390980; x=1760995780; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mOWLy2ReU9S3a8hxrwEO70N9dA/q3jgwHcwqRTIHRtw=;
        b=ZmlrZ1LECeMD7J2kYln6VCfwvOZ7cHdQDHFo0UpbChD70CNPEKBUbn7LjWU23H03QZ
         AEjtqu/LHOkAVYKCr1zl1Y+1KaRcQBr5mdVvnE1W5g0vXGOlyAmKPd7wcGMWeTD98kHP
         tM+IKFJa2Lwy96lUK9kDH4FuyRVLrGi3RaVGJz9QvRpxqeme/orTrS/O0EW+X+7QU752
         FD5XnjIdMgDXC0iHTsH4WrdvFSGm/caijXDzLiBv7NhvlV/Q6QbmABUUltS75tVuF3cF
         D431z3Ko0By3ZPXmxW+3axXwwBmg/a7W7uMC5kjW7/+ZEwlY9qvH7gs7lXRwh8NkAB0N
         NEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760390980; x=1760995780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOWLy2ReU9S3a8hxrwEO70N9dA/q3jgwHcwqRTIHRtw=;
        b=WjP05salhUsPBRKgIi+60gdwkmyQQC1ul+eDsMGlyeJsjMIguZQC9OeHFqmmGMpvUK
         Z9PD+5LblLu4ugU09op2HUHubMB3pBlR0hccNv3vYz724Zv9ZjvjxzMDVgds8i5fqV3/
         mDt+ze8Ea9mUTvQhwgOyNlP8KEAaNiQhC56gMGAgQuz8a1LcUQrL04Qrn33bzWYIE9+J
         D3o4TB5aF1J+tU7fmsQh3Lb7Mgei6zc54T6cX+NyHxVLhqXV2zOFl/ZY99xikDmkBiVf
         sLvIgH6mTpiIInvZhc9/zPtfTOIH4DH2mAbrPplp7o4iyIJTEL9Ogr50z2nf5LIzjYLa
         fUSg==
X-Forwarded-Encrypted: i=1; AJvYcCVr+a0P0gmHaU/AJu7wUkOz2Nw/hfCBpnB23HMgHflSxrFQ49urRLmoIYMZ0q73Pkdu19ENn04iXm9KUxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM06v3BTB0CSi91PPcOMZv0hb3xiFZO38xEzU4hz4sTL4POQsr
	4lQumyo1cQN4f03v/oFkcoyQMHs49IH1YcATQzIJTVqp3nL6KBEy8E57
X-Gm-Gg: ASbGnctI4JGgf7AGScDCQAPgANM6XZkv1cmF1T5XuFsmpP86FukyDwXsVS3cZ0xZCGO
	ejiBzCA8U0VsvpSyE0NxUCx4TI2oB3f7dapOaEF2Y74wYaZGD/eD/QeLF/6A0X7JZIyXkqU1g3A
	6e3Vp/NAdz4h4bJGCPS1umQ2raa9ndt64PwvNM3SmLcBEpfYHjQLp2YkxsegAa8cIlwasTtp6Rj
	nXn1CCg79DrwcPGzg5M4t/7TuQZVboFP7d/HpmVVN/l52D1p85uePiZ8yEyM5TtZ5J07rwEXSBn
	x2R0SB9A2xqdX/94NqUKYMdigmEfXReVwq3KhX2n8txm/kUm4P7yMiodjOUzp49K3+5VMOwxQEr
	pUuPqXIUNQF14qhQaPhlwrYAvq5VU1oZhBS3teOHHFPVpws9ctoL8gUTjdMxxyWbt1AtfDmzM23
	XuGjeWgB4E1VFyrA==
X-Google-Smtp-Source: AGHT+IHW8g/iEhv2J+4UoExCIXe1PUG/Jo/QjOpGLvwucCSkwEBmIaVL1lwMCglXd2kofhEJ3pHA4w==
X-Received: by 2002:a17:902:d54c:b0:270:e595:a440 with SMTP id d9443c01a7336-290272cf91cmr275295985ad.25.1760390980454;
        Mon, 13 Oct 2025 14:29:40 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f366c0sm143218655ad.94.2025.10.13.14.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:29:40 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:29:37 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Jonathan Denose <jdenose@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lucas GISSOT <lucas.gissot.pro@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: Kconfig: Fix build error from CONFIG_HID_HAPTIC
Message-ID: <aO1vQYCKU7fA0Fxm@visitorckw-System-Product-Name>
References: <20251013-hid-haptic-kconfig-fix-v1-1-b1ad90732625@google.com>
 <aO1q4coXPqU/K6KI@visitorckw-System-Product-Name>
 <CAMCVhVNLr+2ivRo9T4rVt4mkncwbOfXEL9bE=pDGRp=Qjy1c9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMCVhVNLr+2ivRo9T4rVt4mkncwbOfXEL9bE=pDGRp=Qjy1c9A@mail.gmail.com>

On Mon, Oct 13, 2025 at 04:23:36PM -0500, Jonathan Denose wrote:
> On Mon, Oct 13, 2025 at 4:11 PM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > On Mon, Oct 13, 2025 at 08:54:57PM +0000, Jonathan Denose wrote:
> > > Temporarily change CONFIG_HID_HAPTIC to be bool instead of tristate, until
> > > we implement a permanent solution.
> > >
> > > ---
> >
> > The "---" line here will cause many tools used for applying patches,
> > like git am, to discard the content below it [1].
> >
> > Please don't add this line unless you don't want the following content
> > to appear in the commit message.
> >
> > [1]: https://www.kernel.org/doc/html/v6.17/process/submitting-patches.html#commentary
> >
> > Regards,
> > Kuan-Wei
> 
> Yes, that was intentional, the information below the '---' was
> included as additional information and not for the commit message. The
> error messages were too long, as was the link to the longer
> discussion, and this caused errors in checkpatch.pl.
> 

Then at least your Signed-off-by tag needs to be above the --- line?

Regards,
Kuan-Wei


