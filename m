Return-Path: <linux-kernel+bounces-832496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B635B9F7CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B987B17B39F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A4C23027C;
	Thu, 25 Sep 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxGbSKR5"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2D52264AA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806287; cv=none; b=jvwifbalwUcERcGJK7BPUZitIGZ+7+9ea+VWcGW5lBP79Rc04Id6p17wjvv2yI5nGp2jmvhtmFOv8vIoqg82z9pyjEWDgKDl4nnxC4UoAoy6RRuh7UCbxDdVrLWI+02RLjPYafzja93oGdf8S3GI3IJmPBcB91lvswXqeWSd4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806287; c=relaxed/simple;
	bh=ZjgBRVmacMq3m/8j2tHZER7fznlErM8dyVvrWaoAq8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/s5Nmg0ct4Yf6aXkJoZ4wphZlMnqe8pQiL8RA+wLlURSFPwQeNwSQNSCu2eaITwO+0+pMS5hdJMgaRcybTaJmy0dZYE9cTLjYC4bekfEMI2lXnlnQ9uOZLF/TlrzZN5kwJy+gIn6klo895xxK/YQX2Xocx7zIwhocSXMRQ+0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxGbSKR5; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2680cf68265so8526015ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758806285; x=1759411085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A59+KnWgnRDWwCndYO/bgXMX9fVVd9cKB2EbYw7Dlso=;
        b=hxGbSKR5oXgRxi1vKR0edL07F0vQVDFbm9+gBRFw0inx94MpPdDqb2XS3BPATe47tw
         8xOwV2z3iAygwx9gQzap5ffuzNDXj+NzB9VxzrXymm1ARjzOsU3AHrc2Nhg2C15HhdpP
         EgNsnhOcqJRvSVm+iMBJCBrIkX4YsaizVYS1M6PzVwS4RsldfMGGlC453b3BAgiQ38AW
         wzr2MdBF3ZVuoRbV3dKS+u/Vv7VZyobedf+YPamc5fc8pw4PYGD+n8XcNLsL2zSN9Ouq
         +/WIxm1BJyHnWvQiulKWMtideWdwH6DmLaAEc7XxF7rP7XXE1i7YqUdk/0jLppjtPFsc
         jlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806285; x=1759411085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A59+KnWgnRDWwCndYO/bgXMX9fVVd9cKB2EbYw7Dlso=;
        b=gsLBY6uNYfBtRXzvS3QK6CCOFETEUpZGqNJxUyNAqfAE/SQUpiNZ6BtukDl98eoP6/
         uyArMTe8jwfW2vpzuKjZ0XKiHgcifjk1DuWHD5K0XooH/Hy0kfIik2RZb0357z/Ob2Pf
         G4GZhhyU7HH0tsQU1wGbl1b1xz8cqpaSPtUWSBZD2RFIWZrQZBmaxD+8Vij5jBE1all5
         c5xPoPNHLZKBalvZos/XEnAPpr79z1NTas3ZTi9xrFneayIBAHBHRiDeTxK+rgVXRVHI
         GShz/1tQ3Jj/AytgPCrxOg531a1UABSYWIqu2+eIrzytKW/crTchNb5mq1UHSE5V5EgN
         Gv8A==
X-Gm-Message-State: AOJu0YwOcsuLF82f6DsvEoogt9Z2cF15rj7PmJ/BS4AGW2lS9Gy4I1V0
	2rQrktIN0ENmKS/mv5OQS3GabQjubVwGPAJsFXqS/NjOsH7AHmUBqtjr
X-Gm-Gg: ASbGnctflzaRNf5R6nqmaySC/4vJIcwouh4bUISizAqfEmnHscfbncKsy9+od4VjPem
	ZzOZmxOQ0/YM6Xa17fJO9s23mfr5xsncBeI2WcNHyHYYSJ9ML4aoJL+ep6XQwJx457hPad7z3wF
	zzpoODzfW6BotJxBt1EMQIy3KCT3rfbBjPj7+f58nx1H3xl3OIDeBciaV0L694sKWnttyhAxlg2
	FsF/7XyK5OOOfKn+nxKQQ03OIeHRvYOuaHcFTlkHMTVtNQIm5QpWVvAeruskYs4lMNRlEtcRKYX
	oS1Vhu1lfGvMJ3lJlixrCtPNBJDbdIOukj7eprSTa0WlTYUzkVRun/WpZu6YmKJcAscoYXwq34i
	3OwntIlg3A/8/3fE67zlSYQTxnfummraAcPVQQEdRT2p1wlpqszw=
X-Google-Smtp-Source: AGHT+IEhgxDJV4w6LBxDgIxnPw4Cz47WhRViG9/189lIlyezvLBhTYp5XVfc0KkFSviOi5iDQnOxuw==
X-Received: by 2002:a17:902:ebca:b0:269:ba77:4eea with SMTP id d9443c01a7336-27ed4a92b47mr39911855ad.46.1758806285150;
        Thu, 25 Sep 2025 06:18:05 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882232sm25121035ad.92.2025.09.25.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:18:04 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH v2 2/2] selinux: improve bucket distribution uniformity of avc_hash()
Date: Thu, 25 Sep 2025 21:17:55 +0800
Message-ID: <20250925131755.13203-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEjxPJ7DgWyQYwfR4T2FZCw6f5SLx0O0jgoW3oyoQi7G8dsWQw@mail.gmail.com>
References: <CAEjxPJ7DgWyQYwfR4T2FZCw6f5SLx0O0jgoW3oyoQi7G8dsWQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can you re-run the latency tests from the 1st patch and provide the
> results with this one applied?
> Also, checkpatch.pl reports the following warnings; please fix:
> WARNING: Block comments use * on subsequent lines
> #47: FILE: security/selinux/avc.c:160:
> +#define C1 0x9E3779B9 /* 2^32 * Golden Ratio, classic constant for Knuth's
> +    multiplicative hashing */
> 
> WARNING: Block comments use a trailing */ on a separate line
> #47: FILE: security/selinux/avc.c:160:
> +    multiplicative hashing */
>
> total: 0 errors, 2 warnings, 24 lines checked

Thanks for the suggestions. I'll update latency results to changelog,
fix the warnings, and then submit a new version.

