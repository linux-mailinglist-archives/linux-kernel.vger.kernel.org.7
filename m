Return-Path: <linux-kernel+bounces-795519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B158EB3F3CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AF9484D22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021FC267B89;
	Tue,  2 Sep 2025 04:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyayqEme"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA713B284
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788069; cv=none; b=SbnutTMruQqQFb0C+mJpaAezY8UUvkwnMJtNweArgjblKgkNVnnFrXd7salWT7UOJvy1mx3fZQvCdOiFOltJnph6+RPtbgl4OAG9dsoJaaWFFXXs7DFBtqSFDdHdg2dhkujk6RtzjnleQmALKF3O7P8ps9L3wYQREV2CuV8hsaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788069; c=relaxed/simple;
	bh=1Jx/L8OpsghmoDgAgZ0IiHINfJhqlupQ4TZ2oteBB3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQfvPmKXBRBu4WUAzJGrkFoGeuKovv64lZxRJ9za4xDV2wfKRpMEtc0CHtQrN9989ceWBbE3NPmrAI4H52No2g709+xDC5gyahaGvOHthOxQcJYLZbKYZfchdwqn0SGRATE6z4UNkqLxYu8ji9TVHMSRgsAuleKfFCoiaNBM98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyayqEme; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24936b6f29bso361945ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756788067; x=1757392867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfbU5zwHO8TMKk8H4KZI6ekBVANo4WZXmivOoJvPB3k=;
        b=PyayqEmedyhHcm7jTImvjn28pDoCwDeqMn3eEZa5lBDokDtSUYQ6BbZfG0qz7SaKtc
         ULPwH8kLXO1FsbhiMkHIIOMueIMjF/dovh1ekUDPp5IIQrWmmGpKNymsoCBJn5R3jud2
         8Ef0hH99VUDfME3dblpYg6M8tAv1PjhDKST1n/si+ZdA4g0znbCroipkAuQslIAnyL/4
         giWPMblCRIXupDdV1Xeju9ogMYWyguCHnZWQCcEzMlgHFTR0Lkl46oJ/uxcFjLWwmrxz
         qDtCg2E9VuFhAnMzlSMen4JvJPwieffGfVWKb3aZcGIo8paRrF1cT2pFmW1oXWQM1wiF
         WuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788067; x=1757392867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfbU5zwHO8TMKk8H4KZI6ekBVANo4WZXmivOoJvPB3k=;
        b=jFSxxZoQJm0EQjOkw2dKm010gsVOtYaP6bMNrMMbY0S2Ew4rTmWyOcRdumkB8ZWzMh
         UA6j/MRwjVGevStXRq0j53itMEEhUGVvaZuepKCUnoWIJz66it7iX/umKMmsQ7gcyOoR
         6kwHN7ujQJChxFT39O3aLdBXPn+ttRdSzaEhM80MIOFTHvQo2EkdZ+RlgnTJfBBr4Ozx
         X28wn2ZXSXw5oAYi/iebogR4iUxELKLPBx5rPu6BJsghN7JczUFTXY7f13f/g6f4K2O7
         jWfDjXpb9Wu50i1UmYC8JUo7t74D+ilpZ5XoB+17ehmhCD61Q+vHZ3k2DKq9mC/wFaWJ
         rzXQ==
X-Gm-Message-State: AOJu0YwQSdHqGq/b6my6IrmdFgHeJkonBeW0JmD2GUtV+TruxaNyWLek
	J1BP66hZe11CP7fYwGFyUcXWsbicweuz4g+Dgt04NnetGu5OnKu9YcAjxrJ7XRPnJw==
X-Gm-Gg: ASbGncuS6PTfug00pIZaN6iUSTkMEOKaSkXgX1YrtrShTT815gLGODq5uJ0r4MmTnYj
	AJ10oMGwPN+zjZwv5qQLbMdAFe8f8LXIOl8vQA9wm3IW7fWJ+aT3ud7sPGxfGFhlPkVMCfx0ye1
	qGxzSZKAWslFuaeLU8vbKOdyL7K1ZGI4mwjX5/MjAlxdDUih1Qcexh0JPL4PjA0jLmnDB+EA3g8
	wblMnB/kWOqOH5JiasNECy2o0A0igsCAKr2T4kUxCKIG9RizJqgagNgvCMp5VanD8WOtq9Mh8te
	oxPLJ6qVZ2H7ePIR3Uac29ZE7yk3Ls6Ri0Q5eawuNm+pG03paB33BwFjUTXKjsX5IU11Yuq9VFB
	nzKaAApvfDbDEbyK/JYO1Zx/KyzIvS3KjMXaLnui0XOI0Z9k7TPZiZnJhJtYrhjBsGxGyw5TWZC
	jKUdmCJqRg
X-Google-Smtp-Source: AGHT+IEEfndQLlDi9IB5a/JDWcrq7ZqI98suhIFYMQANbBZ0bPkpVvj3T0Lf3RlFfnHy6G7ysA+YlA==
X-Received: by 2002:a17:902:ced2:b0:231:f6bc:5c84 with SMTP id d9443c01a7336-2493e9224f5mr8091025ad.8.1756788066869;
        Mon, 01 Sep 2025 21:41:06 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b12faf558sm8663235ad.69.2025.09.01.21.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:41:06 -0700 (PDT)
Date: Tue, 2 Sep 2025 04:41:00 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>, clg@redhat.com,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as VFIO-platform reviewer
Message-ID: <aLZ1XFbMngov-UBd@google.com>
References: <20250901191619.183116-1-praan@google.com>
 <20250901144043.122f70bb.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901144043.122f70bb.alex.williamson@redhat.com>

On Mon, Sep 01, 2025 at 02:40:43PM -0600, Alex Williamson wrote:
> On Mon,  1 Sep 2025 19:16:19 +0000
> Pranjal Shrivastava <praan@google.com> wrote:
> 
> > While my work at Google Cloud focuses on various areas of the kernel,
> > my background in IOMMU and the VFIO subsystem motivates me to help with
> > the maintenance effort for vfio-platform (based on the discussion [1])
> > and ensure its continued health.
> > 
> > Link: https://lore.kernel.org/all/aKxpyyKvYcd84Ayi@google.com/ [1]
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 840da132c835..eebda43caffa 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -26464,6 +26464,7 @@ F:	drivers/vfio/pci/pds/
> >  VFIO PLATFORM DRIVER
> >  M:	Eric Auger <eric.auger@redhat.com>
> >  R:	Mostafa Saleh <smostafa@google.com>
> > +R:	Pranjal Shrivastava <praan@google.com>
> >  L:	kvm@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/vfio/platform/
> 
> This would be all the more convincing if either of the proposed new
> reviewers were to actually review the outstanding series[1] touching
> drivers/vfio/platform/.  Thanks,
> 

I was catching up after being away and just got to this.
I've reviewed the series [1].

Thanks,
Praan

[1] https://lore.kernel.org/all/aLYYvURhjGmJ__Fx@google.com/

