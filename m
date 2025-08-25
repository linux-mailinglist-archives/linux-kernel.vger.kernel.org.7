Return-Path: <linux-kernel+bounces-784755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F2EB340AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D07E1A84EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087D27281E;
	Mon, 25 Aug 2025 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyTy47B3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D4205E2F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128542; cv=none; b=Da4ANS9yshGMmx64ggOzo5HzHkxxdcABLJ7wwjViBFhSkxbrt2e27HyOerqCVsPSWXYdqmM5WPbkXX0VQ3kHT8JT61zmooY/a9KR0aUSJ5zvliWzzC+60Hepfs26USerrle+JeOsCi38MDjCjJOI3CM/v8TZgHzDXRE1A+Zl0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128542; c=relaxed/simple;
	bh=0yff2LpoJnHEQt5aTGtyODb0eaeMmkFCh6B9O8f7CpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMDVQkJ7dFdKINEtUbg+PHW31t9Nmu/kPAPXhwnP7c8hG9veLtBl0jWitFgMxzLW81UfPpCEyhSIOy/QKq8gE2fweCPmdKpTbsAV+COxXlFIUWciDAk3BJZUtQnuJy2KQJtG3rBZCmr7D2ZovKSRmeOrMpCsT8KSp6uOu2rZaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyTy47B3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756128540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xs+Tu3bRpdzcsjYBxYYo8Y02jOXY+XlScB6sBjefWzs=;
	b=FyTy47B36qb7YdJc/fbX3iELxXvpj/2Uv1qacpmbWl9Py0Qm8UisQUhN70DY2jIyPXVYyX
	tKN2nXRGOphewJbCP1A22ok+CJztn+i23YI2gicDcv18D+9zIk47JKyxvKsHPgpFnRO52s
	8EQ5sxFeGpT2JdHCVe6RMpeafUds9bI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-kN-Pr4udPm2mmXYes7dlyA-1; Mon, 25 Aug 2025 09:28:58 -0400
X-MC-Unique: kN-Pr4udPm2mmXYes7dlyA-1
X-Mimecast-MFC-AGG-ID: kN-Pr4udPm2mmXYes7dlyA_1756128538
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70d903d0cbaso79769256d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756128538; x=1756733338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs+Tu3bRpdzcsjYBxYYo8Y02jOXY+XlScB6sBjefWzs=;
        b=bZdkqTI7srNgwoCsaRbjcQHZ32Rxx1eK1gVaMKuzIoSU4BF/yyae6PFx3owzU79BCo
         i8Rua4YAAjwLNMwvy/Bjj5Sq7tqVfsYTbUJBaYsrLPP1l7+EDYSdlkr3eCtoswth5Iyt
         TO1yGrWFr3CGJCZIEFEAbljR/DCKrLYtC1TgHNoPYPbxl6ZHlYOpCGn/XG41tX8oT4wZ
         AUNaA9IcQBSwd2DzruMv3Hy8KblSBDtiCEat10rAcz66jgIr7p4btr0fuVO9WKJpvWUI
         r42GYUYyzO6wbPj1/NLwFXa83NSc/E114S+w0uPqLUFZJA7STYhEfDbgXRVF20efouGQ
         uPBw==
X-Forwarded-Encrypted: i=1; AJvYcCXlsWLmiIKJgmOOLDHqyZVyLVv9KfhWr8D+mtdswaIiFouqjsIooQv6Bi9QGt5FPekKaWmQd7ZINTw9Uy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBvbRWDzmFtICHUCXrdfCngvnjSNwk4AttDSwAs7QxOLHn9ZzC
	7Wik5kkS3VLgtIYZKA/GFuCVRLbqKzi7HBT0CxtOJUgRCnFHr0yNB+m0A7SqHx2J8+NU+wpCp+u
	zHz7R51MFAfeeIn5jyuPd0Kk8h+vQDxbwhIU+xEjqAc09R+GWmq4Yu/ZZ8EACPAUTGw==
X-Gm-Gg: ASbGncu8sWSUl5wzfRmDwD7iXdWjvK+py5CKlqrdmhNx2RBMwm4U5n9atwSQXqVXMPa
	wz4aUDk8NeNPqWmcpze0Q9habzUDTyHkeruFRDBX0i50ztS4w56hFek7H9ZDO3LcSMnN4LSsj/N
	usCSi0+w2vuPlnzJU83pCoyYtnmawLF0+WBuJBLlrHOeNW5TsUY0LSwch4Jb5TNPyLboKJMehSh
	ku04CjYlM5BFFw9v7lD1UqaGrEF/TOTv6vLjoNuCp1G3lgoUtNwoMl/3BlLgkvy3ylCpFP5lV/C
	ZHq3uF1K74jsBtE+FMNQPZ4gKiRqZzJTNQ==
X-Received: by 2002:a05:6214:518b:b0:70b:adf9:bce2 with SMTP id 6a1803df08f44-70d9837efe9mr94799976d6.20.1756128538241;
        Mon, 25 Aug 2025 06:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu0YB1Y5ZYTZ2o7B0Gvk4C/QMLdG541HyJVolkrvoTFoJmhnpSpmIS4mvxM9BASZEQVvZlUg==
X-Received: by 2002:a05:6214:518b:b0:70b:adf9:bce2 with SMTP id 6a1803df08f44-70d9837efe9mr94799686d6.20.1756128537742;
        Mon, 25 Aug 2025 06:28:57 -0700 (PDT)
Received: from thinkpad2024 ([71.217.64.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da717df65sm45334096d6.30.2025.08.25.06.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:28:57 -0700 (PDT)
Date: Mon, 25 Aug 2025 09:28:55 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: lenmn dza <lenmndza@gmail.com>
Cc: "trenn@suse.com" <trenn@suse.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"sageofredondo@gmail.com" <sageofredondo@gmail.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpupower: Add Intel boost state and frequency monitor
Message-ID: <aKxlFxZOlqfjaF_B@thinkpad2024>
References: <TYSPR06MB7600C90A1D3FA792F3284771BC3FA@TYSPR06MB7600.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYSPR06MB7600C90A1D3FA792F3284771BC3FA@TYSPR06MB7600.apcprd06.prod.outlook.com>

Please resend with the patches inline.

Please see: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#no-mime-no-links-no-compression-no-attachments-just-plain-text

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


