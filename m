Return-Path: <linux-kernel+bounces-862887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91418BF6739
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D0B23556B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F682E11CB;
	Tue, 21 Oct 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArvnWsdi"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295CC35502D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049778; cv=none; b=rADYbuL3Y9tfzcToxhEMyOsgiJMb6pGwEHeQLndR5aXTJoQtK4BezqL2l3S3D7fWSMWeYjlPBLmzpWe92/+MtYZSDHrT8zq6HkPceN7s+1wS5VbaFGkIUZhkqAHOJC1ot85rgWZsQO8kK9iTboh80mCXg64lx5fAN7+3Ggqc1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049778; c=relaxed/simple;
	bh=mJvjEcn9y/uwoBqEtgwLDNdS3hqWkcvksx0x4ZkTH/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mzmfIfhxva4EEhaPs7UIu2QDXoTWa+7G3vfOSUYGqcFDAw7Ye0OOnwDaB3+KYLrqqiG9bocGvGZ43tWylv3M65p2x+ri0UfnLlSoPhSb7RgBLnMrJLE06l5ZRaVnr/4znmf3/ZWNRsbOHncoICHsz4i3vwOfW+XVxG0gdytrzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ArvnWsdi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee12807d97so5193033f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761049774; x=1761654574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxKZQ1jSq5XmEMDD7h85b87KnFfLeeynwokLsqHcE8c=;
        b=ArvnWsdiOU9cs2gvLgfy/FgObj2wAH29pZzHQ7iwFWznGRcjO2yag9XSTMbHocJ91Z
         XHmN7BKI/BU+5/NHynBlblD9rg+1+cxa1jbfS0tozyHJJKcam4GEaihtRfz5T8zf93SM
         X+bzMpU0TQ4iOqzCBLGt+ssm6+jn6jdq3l5RQe3VEiVnLkHTpRdFV+vmG3J9pNPBOBPV
         rBGBOfLaTTFZgN6ub7mChfhyi26Amh2gxiijyqnGy/A/0aDGzxJXnwG6md8injyu0dP5
         ovpV3mF5oFY4b+ZAm5AC1OFDacgl/Ax2VNesAhgBeR6wHX+dYvS62XdqKyD0+NVg2fTO
         vUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049774; x=1761654574;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxKZQ1jSq5XmEMDD7h85b87KnFfLeeynwokLsqHcE8c=;
        b=icxlVF0XYdmT7gvHZMMw61LL5V6Y3k9KOmEMXRF0eK6o7qhnyOqzuylnct6bNeMJfn
         Hd8ZiqJjqtXwYIQwHASXKfKZM8tPMsaGxwsD7LiYJnDoB/HfP9IOStM78EOXXtqIHMyb
         8uGcgVFLP6qaBNkbuwmSWht3+lqEpaHFvWo0lDDnvDXfD5Vs+u22YeYAK4bJXTRpg2MQ
         ojmw3zleyVmz5BsX/vsO9ETgmi5cqfZ7C+HtVIOgmNIJYp0uLePDW5HLYWQJdtnXV04E
         F/bIMiHnu1C6gllrcf8DDuAhPBkbQcbrYzV2rywZ6czg2oPpgbtlF5B9EkMZ0UFo7vC/
         e/ww==
X-Forwarded-Encrypted: i=1; AJvYcCXLhHDbkPmxQkoWoqeiPsJZc4GIMjqv5ji1ctm1R1pdh33HJV3RUTBory0YXEvHeq0voQ3KZIDNAe0Lwmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEZeQDStFF8T4LpOpGeitXAW0CV9hto9KYv6fAlffmH0cSY+0
	aOk4ojJgSS7JyOll1QZd5cC0dNhAYqUYWYVt1WCKEvry6e5eOf7k0+Vai0hEg9U1qqA=
X-Gm-Gg: ASbGncsrHVij6JTiYkgwzPWoB4oVMx1dnMrrQQZxRoQpcqNbX8lSkdTCyGDjozC02++
	f1XJxVk9R+r37JWZXoJjSikEw7d/uFRw75RwfFkyhGCkJLcfjCJMqngeKxv4A4QEIVz9US/qcyA
	ufHASpI4MfQhVA7mPwHxvzLaRewQlf51jgjDo6s3oopK5LhBeSAwXuNpKvw8EbEot0BGgFXi7kd
	dO3wCteTcrAT3sC7cQj/BDDplGN0sjuAl9innlxvglfHCBJdTqs5uXaUmqEWwASGe/zskd5ZAUb
	21vUiIy2tiU//7sBi63haM+xDJOJ77deRDRCr/BowDSCZWYas0/Wgg0neUWYZ91biTRqUUjKX2M
	UoknEar1QL6TNidoeyrFqfGOQVxWYEXZpNaVoK8MAZIsczZKbg2lkO+ZkLgD0MiMStb3CBDG+xN
	ZBX9Ax+krX1aQZ6kRj9Vh4
X-Google-Smtp-Source: AGHT+IHoXeRtqP5YKqx5fTjYny6JdBkpBMtbvIMA0MFHpcS+8/Jc5PjJmN78n+JJQ4ygw5kfvtGo5w==
X-Received: by 2002:a5d:5d0a:0:b0:3de:78c8:120e with SMTP id ffacd0b85a97d-42704d43e7fmr9940846f8f.6.1761049774263;
        Tue, 21 Oct 2025 05:29:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b988dsm20550960f8f.35.2025.10.21.05.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:29:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250926142454.5929-1-johan@kernel.org>
References: <20250926142454.5929-1-johan@kernel.org>
Subject: Re: [PATCH 0/2] soc: amlogic: canvas: fix device leak on lookup
Message-Id: <176104977371.3063512.7347854086347476606.b4-ty@linaro.org>
Date: Tue, 21 Oct 2025 14:29:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Fri, 26 Sep 2025 16:24:52 +0200, Johan Hovold wrote:
> This series fixes a device leak in the canvas lookup helper and
> simplifies the lookup error handling somewhat.
> 
> Johan
> 
> 
> Johan Hovold (2):
>   soc: amlogic: canvas: fix device leak on lookup
>   soc: amlogic: canvas: simplify lookup error handling
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.19/drivers)

[1/2] soc: amlogic: canvas: fix device leak on lookup
      https://git.kernel.org/amlogic/c/32200f4828de9d7e6db379909898e718747f4e18
[2/2] soc: amlogic: canvas: simplify lookup error handling
      https://git.kernel.org/amlogic/c/075daf22641870e435a16ec2129bfd3b3134c487

These changes has been applied on the intermediate git tree [1].

The v6.19/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


