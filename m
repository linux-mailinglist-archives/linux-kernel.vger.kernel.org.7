Return-Path: <linux-kernel+bounces-898110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7F4C54688
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A69184E92A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60D829C33D;
	Wed, 12 Nov 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Egm8LDRI"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E472BCF46
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978168; cv=none; b=nG1ZstfDzmnQCHoCwwDvwcWC4IsyevC0GWdft72ShC2P5XDkGlA/XOOlkd7SG7pldl2ZErVAzleIaCnRTpau3LdJ3MUGbvb8ITf1QOZHlCEN5WbO92GZtdJTXlhxJKKSU780TQZMxKQA5jIZMz6RmSwZs3JBncaRseMsxLkxygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978168; c=relaxed/simple;
	bh=Er3oR6+PkdlXB4XEzW4SKH+apkSu3gszkGr+FTLFVQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsbJ3+0o8O6vjpGYTVNYUxsB1Ev3XbJ3+wo7t3kgULwJCftcP6CsWf07afd8fp6uuM9PuLWp49u1JXE6EzWQTEEsVV2vbQT+R/x6nMjprcmgRrvNQs3ukdYDFb6CKwnMz6ojWwospYtuVbI2umzJKDoUGqxlNwdOYI1YY6S2tsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Egm8LDRI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2964d616df7so222005ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978166; x=1763582966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmvW00LBZ50ailbcS9XTnsttPz016ujPos9JYGgCAT4=;
        b=Egm8LDRIswfqLLZ9M0ef0fAphIw5jfBH3MhXlu5EwvyG6nTXpcAf3k5+mBwpPvai91
         lOXgxYPCkv0B757PDkO8lZW8TpzpCWWcNHOEWLxuN2Bsjz87fQeRyxI3Q3EBvWwiGydJ
         Mt0TZKuaZjKFmVdHtfREesMcY4Ceq5jilGQ0HaWyFXfnHOWDAkTfUNyORJ3dscADIc24
         MeZ1lNDkQxd04itdd6XugVokwcow9zlnqDDKpCja7YsnfHq72ncVjTv1Ve2DBZ3tNyhm
         VhF6lrJyNqGqFlNaK9K9kuvfecWf1utpuooAX0NSZtNb2ujNVuWxYAPce7UcyIAxPGnQ
         NRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978166; x=1763582966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NmvW00LBZ50ailbcS9XTnsttPz016ujPos9JYGgCAT4=;
        b=Nj1mpqccLsA/S8s6SEQubs+QyN/T7lmlxCr+y00YTDfXrt+ztyj87XYW2Djl1V33xD
         2DV2bo7UaNX8Ji9/xf3RWAlgR9ze+MItCi4v4PRweemASIjnA3c/t1VWlxEHliKzAjtJ
         N9803Zfzw0io7Gw3PG27QMJS4rhxqU8HzomJHTh5PUKGrDqxf9bu1CAPNN9uukKdtyoY
         cSudgXH+CINNxFW5y4nv/N93NCAWRMAPP/lp+XGxepdC9johzEs6kXVskGc0Oy0C+bN3
         3v2k1VhGZVb45xoiEZb26M2/eUCUVjUbxAI2bOxMiN/OeE/FGqAb+C2wrp26J5v97fCj
         jh2g==
X-Forwarded-Encrypted: i=1; AJvYcCViMMSKnyTkDWFOm1KTmqF7uof+RkvSao+vgqQ7aEJ5l4ZffKkJLOa9a+2m5PaHb9eFwXJF0lZMduUAys0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypqpHLSTQQUNKW4TcotjtvdqQeY8GzBf2zBv06BmOj5UHlY49M
	Ij0CCtXbTS5iu1qHXniUe3a+WZ3B2PmTi6e4DxHiEs1fADZbgKU5blEA
X-Gm-Gg: ASbGncscWwL47zJRZaXcCXk9qcasgZZrA+DcMeV7nLV8ksQr1QFqKDo2T7DXKiOohgN
	HVF7nsJjrip83nTAVbnJWAutvUTX4ZPh47VkQt8xcGpMe22EJWSh69iTFAOi4WK45VAHyAz6CPk
	kO1VK6x5jDEGbSrenAzt+B3jyN40E9d+Fprw5yQpxQDEc9D9r1hphlLYh0MRsCDVd65eqPQb0Ji
	VMJ825cnoSp6ZEkWTAUq8BNdLBWCVZf3TmSDgYVI6GJGUdxbEw6xScr3KXtIiFiXc+ISQlfOBiC
	fIGe5sG5C2gi+YvE3eVjlk7l+eSJBeaBl23m5e0MoAR4Cki5AFYC1nprpcQp5bANTLOrLQ+jW89
	an8K/VtCRnyg19G4YNetBEex3sxtamqdYS4tyFfX1JaI1R0toRMrND+Az2hQsFXzS+qWny5V+Nm
	voVY78cDdy1yuu
X-Google-Smtp-Source: AGHT+IFItecs7CrhbyEkdqRwaoHcd+iAO6zPDCEwo/LpsTI1JbO3EYuhCISQUIPuyHp328lDKaraXA==
X-Received: by 2002:a17:902:f70a:b0:290:c516:8c53 with SMTP id d9443c01a7336-2984eddf03dmr51151495ad.40.1762978165661;
        Wed, 12 Nov 2025 12:09:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dce80f3sm39020015ad.106.2025.11.12.12.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:09:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Nov 2025 12:09:24 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Igor Reznichenko <igor@reznichenko.net>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v4 2/2] hwmon: Add TSC1641 I2C power monitor driver
Message-ID: <c02c8209-8f96-4ff7-992d-c81af54d5604@roeck-us.net>
References: <20251105201406.1210856-1-igor@reznichenko.net>
 <20251105201406.1210856-3-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105201406.1210856-3-igor@reznichenko.net>

On Wed, Nov 05, 2025 at 12:14:06PM -0800, Igor Reznichenko wrote:
> Add a driver for the ST Microelectronics TSC1641 16-bit high-precision
> power monitor. The driver supports reading bus voltage, current, power,
> and temperature. Sysfs attributes are exposed for shunt resistor and
> update interval. The driver integrates with the hwmon subsystem and
> supports optional ALERT pin polarity configuration.
> 
> Signed-off-by: Igor Reznichenko <igor@reznichenko.net>

Applied.

Thanks,
Guenter

