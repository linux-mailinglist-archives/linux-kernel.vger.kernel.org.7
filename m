Return-Path: <linux-kernel+bounces-864437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A33BFAC93
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D8504E5815
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEE630596F;
	Wed, 22 Oct 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUx/AVC/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BA303C8D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120398; cv=none; b=HvlDqoC6rmsP062OygF8PmJZFkdstSrBGd/aB5EiZn3NGrfRRjhOSBFq56X2q/Ecgpb2T8IMg+R/ZFW/WXPKwAjRTNbE7dZfzSQOecs8aXWcZ0QZdXq2T9dVCf0EhobUFJJF1swW/t0skPNkBeq9sqloGpCocqnbn4KT1PYRweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120398; c=relaxed/simple;
	bh=eyBdO2wWOgqsPzs2lpBJ9/L31r8e4dCSgvgCYmxIx6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QF+eOX2Te49NTbhe+bUrxh15xCcrcw9zz0TBaOpYtLc0We1fbTwgyZMMzbtK6XysROmX3TQb2h77OuMx1irwc0Q+V1gINak2RkyVgELGfpMr/8min4OlvPdc6siiFMTdfFEgWY6fSSIFThBTeoH8p33iZFcNEBThl+KNRZ2jTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUx/AVC/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63e12a55270so1750377a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120394; x=1761725194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toHlnWQqNYbfD0u6quHogsDi3+miz5wiSuRT4/A88gI=;
        b=aUx/AVC/VZbpE2oN97dtsPHXthi3yMi5uzy00pyB+I/2aKpB1pOF2pRPdY6cZntp6p
         +DxMKa9u/iHSxDOYlybze4ivOTbEBXwIlPobhtH9vR+ofclCSVUnFdLZ2x75oKao2T6F
         BzGLltxDdG1BTWxSKuNX4gqbmqd/hSjjIIFVs0n0Ch4mlkoUiC6dBoLKKuDIBPDKTFUi
         kFk5uj7UUBrRa5xQZqggiEu3sdLoHgwuGvH/67ISB2+jrRmwVgOB6jqYyuXpupwhrpaf
         63/jcsA3jGWujqwOZrdyACWvjfRvauXk4GbFXeQNuFeYqpEhKr8/+iUckaeissAGe+rY
         jSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120394; x=1761725194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toHlnWQqNYbfD0u6quHogsDi3+miz5wiSuRT4/A88gI=;
        b=m2b0gvpdhmmJjNFDSXl5ZJUM3H9cLF5PIJbo2vXve4g+EPPqO6frA0VIsYKJ8MYPKT
         Qn/CnjIcAr33GMzmg4+MYMBxkbXsbNeAnjHx7IEIMbt7vneW0UWPFJtOF+91xgtE61Mn
         UMnbz/I62AIE8qubGyvaL4apMWKgnJEucY/aTzRB7bkYNG4N7tyS4d5nsTK5eOPlX/BX
         cV67wPeBEpYX6/0dqp/Zd996lO5pu0McX+K7C/OYDM1joaiZogEYiYPKTWzLdZgPJFcg
         Zh7sbdhfn5337cXl8jPzMDbbh4diqt+3SUxqn6x7Pln5rxXJ67EedYhWmaKYz/6O4xWf
         b5gw==
X-Forwarded-Encrypted: i=1; AJvYcCXAdXNwlTwmniBRP7MswNSls3xX7krewk1fHg0eDUxcm+skKrXgZdti3y/fgBlrLdhQyrXuJxwxl9o0jMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rZnpktII7ycY4xQiAzbp40QHJxj4dC7RPWm4iF+7wkjDLYFH
	Ryp0vPXLYqtKPsfs+5mZG7JuCxNM5l9pVbCOz3pMhi5/nvJBmOxZEcal
X-Gm-Gg: ASbGncuM3hUMfPZDe8RqYP82hXYQwcTBrSnNkx7eA5+vN60kuKF3OWP3Ohgw2hNQ/gS
	GrctxfXczdeW3PNqOBf2tjYqP+1fevOSrMKO8N3LC2+C8xXhr7iXl5RoFHv2daDp5SFzptHCf5y
	bs5JOEZuuV8T/jWkayk5TszSHfsjf/rtabCIQrTL6sOi82BKLf0a8G3GnKqccuqMox+cySU75Lx
	H4kS999sZrfoPtRJRXQiOloccTmu/TwjbnDWaU0yOUWyFOzr8i6T9yKG4NQMoEBYl3J2Fw7W3Cw
	5Z7wDzBRRWa+niWf1AGOVjeNSWHj2tVSj1nbtQF4s50VvF+Cl3FjUqq4U6Iv6lOV1HoWo1vfKBu
	/giedbBtmI2gFtOpPr1bLWgt5NIBgMTFXralN8gKsrruQUluL9VanRiUnfL7ENLIthCLWqyznaE
	+o
X-Google-Smtp-Source: AGHT+IFKMamBOdEkXZztW4+a96FX3cVQPwKK7mU8xvsOl5ZRh1X2aHXQdNoBVmqwPChAhbEjv7M9Xg==
X-Received: by 2002:a05:6402:2791:b0:63e:23c0:c33e with SMTP id 4fb4d7f45d1cf-63e23c0c43amr1116868a12.27.1761120394218;
        Wed, 22 Oct 2025 01:06:34 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63c4945ef49sm11192106a12.29.2025.10.22.01.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:06:33 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: bagasdotme@gmail.com
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	arnd@arndb.de,
	axboe@kernel.dk,
	bp@alien8.de,
	brauner@kernel.org,
	christophe.leroy@csgroup.eu,
	cyphar@cyphar.com,
	ddiss@suse.de,
	dyoung@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	jrtc27@jrtc27.com,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	krzk@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	nschichan@freebox.fr,
	patches@lists.linux.dev,
	rob@landley.net,
	safinaskar@gmail.com,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 2/3] initrd: remove deprecated code path (linuxrc)
Date: Wed, 22 Oct 2025 11:06:25 +0300
Message-ID: <20251022080626.24446-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aPg-YF2pcyI-HusN@archie.me>
References: <aPg-YF2pcyI-HusN@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bagas Sanjaya <bagasdotme@gmail.com>:
> Do you mean that initrd support will be removed in LTS kernel release of 2026?

I meant September 2026. But okay, if there is v4, then I will change this to
"after LTS release in the end of 2026".

-- 
Askar Safin

