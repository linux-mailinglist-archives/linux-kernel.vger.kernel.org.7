Return-Path: <linux-kernel+bounces-889948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E7C3EE51
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E31BF4E44A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DDE30F92A;
	Fri,  7 Nov 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrDGGDdR"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01BE30F938
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503142; cv=none; b=uoDQjFaFHbfV5ODVCylKaDOz++oOHfxcWAE2j3jNTwOVaUZDkbLDYs3DaEEEHIPW7+yg1pDN6kzXSw1bmKMAx7y8nOMoXOl0M7AhPzKfN3h42XsP8U9OvO2TarLhwTLRfw3UCF5OY3jCk7NaltX4fz05t1L5mf8MSBjT/kE5+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503142; c=relaxed/simple;
	bh=EZY7NjCHTeI8ZtlYt4fYKNAHiiwdThNZ7B4H5f8M370=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h7T8tC+nyo2QZiOolqQ8az2NjAPD1XOu0JRHkLDlTg0QHdUnT5BVjSH6PPygsH/BEegemf29WzaJz/TENzUAulBp30BlHXSRe7uQPQBU1S24RRRpN2nB8r9+4mT/FN5fy2OBjbViOX8N/2FAA0qFFv3Hb66J9QC7vXrTcO1HMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrDGGDdR; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso434020a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762503140; x=1763107940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmw8BUMis3U7evEGAA8fT1j+khq5yYTTfzGiGGo+D+I=;
        b=XrDGGDdRsITwajm774P6B3Sl3c4je2jXqfD/Aqm7w3inecz0xs/t4v1w1fEvI0AFK4
         wGObnjz4Yin3H/ciIJQMmVd7B1KMgwK0gUnoWRTNzWGhUNjJEAeaCLJ3Fpl14DY4+DJx
         iz/vd/KXRvsIV/RjmLgiVeKi4ds0sJlCHQL2g4zHYSsFqXuWcIdzVsKvQnhWlacvBeap
         rjnkw/rfTyJKMzjsAg9+oe29yy+hZGe5jB/OD2fBjFiLXUl48XPVsQDgOLZ/eFZSu6/J
         i3ffiaaHTiKkVtmGaH9PFCUG5//B9T8kQehFTruaFxi+F2vr89NKW3gONGpn7Pj2m5/J
         A9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503140; x=1763107940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dmw8BUMis3U7evEGAA8fT1j+khq5yYTTfzGiGGo+D+I=;
        b=K27kXd+uVNBubzoUIeJ9lZdA44B9DQrCT+AYZ+maaI+CW0kQpYq4I8z6Sv+mGNBiqX
         8zxvpYkM+ToL5AGfGQ7h1v+DyAQGENT1CUfbsnAOD/0ktB1bLnpMGfNDTktZU9Ko3vqO
         p462YGEVtJw3turFHWhZlHFb8X0oW+f84upRoGCtW/zJCjZWaakEcpQ5LbnM5LLgY+db
         J97Ju8iQXmg5xBYlYdopuEFZ6b+f3vfsc2+Wk0CbCAIhHnOd2uEekWAcqA4QEZCcIdCF
         /3XpREfrcEbfsl6wE4gjbonIxgoniz2YZVOsEJXuKL2zs6fCqMI+qH9HcAB0hqFrwTk/
         /Dvw==
X-Forwarded-Encrypted: i=1; AJvYcCVbw5lFpkMW0/eXMmVVE6OAc6QJn25zCHlgzTsVjUtUu9mgbSUf9egWfhUQQBQt4DlJr8i+U1mC4nUH5L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrj7mfknqvb38AvgRAl10tXUM3qhMpeeTl7qWWfpcO52rD4Wm4
	ao1uksaBlYRJ5mIXYf0mXLFS3eagps2pa0Gqrq6f5Eu6U04vHZIqFD41
X-Gm-Gg: ASbGncsYyO039DGMvoJ7XKIZofyIhQ+Cthi6yh+UVzMQc1amFYvTPJ/U9LSVtCleOAM
	goUETVOYFLXCBhoOt3CmAJhgGWAoNYDEYNHmvWRcj9xiYVkTEF3O492K4zf6MuJq+DGXUTEDZLU
	aWMfVgltHDR9jr4x1mMrCOssRNkQ3Z07sQTzvzy42KCpwTDM7WjlMaZAWK4bAR3VUoxRyx5TA4+
	duERTewJMJZCqP/+C++6EfGGl4PpEXAzCMUGsISKATvUbBHgW3fVZ23J8cQSSNQYYp31kz1dxxC
	WGAYOdq7vvjgRyQvKm6npHSW6ovdG4Z6KduxkhJxZuJgcJO7rj9FvVRl3Qj5f9xJC/ISlYbXXQ3
	CVeDzTPCJSP3gF9X/KqrUhWLmk37bKUuekEthfZI1rC4i0UiJWL54LgunWrAwCelMroMg6A==
X-Google-Smtp-Source: AGHT+IGs1b/E15BQQr7IRWhnvMwkUWjaQl+1pAkJ+WBKp4CDaO9Vgbztv4Mt1ZD4fKUVL35oC8br3Q==
X-Received: by 2002:a17:90b:2e07:b0:339:d1f0:c740 with SMTP id 98e67ed59e1d1-3434c4e4544mr2792443a91.1.1762503139944;
        Fri, 07 Nov 2025 00:12:19 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba900fa571esm4450338a12.26.2025.11.07.00.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:12:19 -0800 (PST)
From: sjg168@gmail.com
X-Google-Original-From: peter.shen@amd.com
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Shen <sjg168@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com
Subject: [PATCH v4 0/2] ARM: dts: aspeed: Add Device Tree for Facebook Anacapa BMC
Date: Fri,  7 Nov 2025 16:12:10 +0800
Message-Id: <20251107-anacapa-v4-0-peter-shen-amd@sjg168>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104-mellow-denim-dogfish-4affdb@kuoka>
References: <20251104-mellow-denim-dogfish-4affdb@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Shen <sjg168@gmail.com>

This patch series adds the device tree binding and the initial device tree
source file for the Facebook Anacapa BMC, which utilizes the Aspeed AST2600
SoC.

The patches configure the necessary platform peripherals and aliases for
OpenBMC usage.

---
Changes in v4:
- Addressed the fatal 'Broken DCO/email chain' issue reported by the maintainer. The Author and Signed-off-by fields in all commits are now unified to match the sender's email address (sjg168@gmail.com).

- Addressed all remaining checkpatch.pl warnings reported against v3:
  - Fixed all block comment style warnings (converting to proper multi-line C-style format) and line length issues in gpio-line-names.
  - Removed the un-documented "amd,helios_cpld" compatible string to eliminate the highest priority DT binding warning.
  - Removed unused and commented-out device tree nodes (eeprom@53).

