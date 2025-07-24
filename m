Return-Path: <linux-kernel+bounces-744722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92916B11044
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9139A1C2560D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A062E3AE0;
	Thu, 24 Jul 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYRJYRRN"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1F2DCF5F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753377642; cv=none; b=hPfe/VSqPf3Q3QdodkUbNA5fQl+wbb875G7ojBiZGMe2XyKD+mLr9cx0ari3V97lov9NYBy/BxoTiOtFsf3YpDQpeoCyR5Tb1ICsytnctQopbjdGZJ33P0NwBtZ6dvQFBqpNx0ZGmvygd9qF3LiH5nOLFdv+Oxc5KRuKULZtfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753377642; c=relaxed/simple;
	bh=JjdIyqho2L1pdY174b2WWL7+9YNKkEJOJ0h/Daqbh7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfKQ2/DguKpzKqvQ7nByWOmm2cFBDoq/Em9fbl60hz8E2zcVCvwD8CG2iYwmSArNC/Prsgws7e7kscGpgtLNGZ87NWnuSR5mDt1mFTeKsYsj9FWxUZgtg3HrLPr2nCPSTOPVJ4I+nuoOgNMaK8uMuyI2PSbGSqTYZWey5hbdvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYRJYRRN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0d7b32322so202123666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753377639; x=1753982439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjdIyqho2L1pdY174b2WWL7+9YNKkEJOJ0h/Daqbh7k=;
        b=XYRJYRRND/PYomIkFYdSX2hEJmmirvtue77BIpqgU2L/g0OC39pL5cuiygGx47mp2K
         bJtg2Fv5sgVjnDm8kM9itQAh92U0ULQoUobx4P/oBg71RtUMwjDxDzCjPuvLxGK7k1Ch
         vHaWanYsjk4T5T+/BQmOvUyxNtoOFToGxIzLVp9jFktOxBLxPMwsp1PmViXitF6ED75U
         XVeJPjnL8WstXTYIUNpKyNdKPs66lOcVHZ9QQTVq1W02qgflMmzfLPrfmYinHx6/eWTp
         6ZYcx/Bwt+yWC5q2P4cwX0IniUjkoyGfVSzeMLovC0Ww5enj28reD9ceHszuH3oVKCLv
         gL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753377639; x=1753982439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjdIyqho2L1pdY174b2WWL7+9YNKkEJOJ0h/Daqbh7k=;
        b=uqIpn0G4zD3SieBrueadXrgCV+Dp7jugSPpHBKpRaYXygKS/spfbIaev753nYaZHli
         A/eVUCyHoaOE4a9HA6aIwwbhNsJuKv2D5CdRDAmjVTYWP9o4ZJ62tkByonuj+Zu/H15h
         R+7yWEla9TeJqNYfb+JB9vbjANyYHutcxICRCMns8qjQ7NdT1Kp7kQ6glUpZWBg2qep8
         lMkkY5102+FX282ICPT495eCPpKo/A0csqkXkaGtGT7CMn7aOpG3SYSLWrsPv2UWoN0x
         dfxHpNhybYofOT9fUKVv815cYSZNslnCfsKaskZOsDXwZ7TBpIwvbyxg8Th5kkDroWlt
         iHmA==
X-Forwarded-Encrypted: i=1; AJvYcCXkGnGEgO3xFOp8OrYVFBV0K/x4cXjKgeXSpWEKIoJkZjulBnJSS3O8pKhihwc57+CDpdD0nPzzHpC7cs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWktpbVsTAtqv/vCZAelQtV7xAvgwLKis4DtsSbSZgN7ogFRoj
	5mD4jDtTp5MU7Dww9D4LqYAVFg+R3DKnQWqjArxCGNQkXQK5EHgLsX4O
X-Gm-Gg: ASbGnctleyFTduFcL9WlqEfJ5Rqh3RsDkc62ar8/ho0y+zb8Kbpm4w1M3ZSYQjtJxJr
	S/6O/z7Hp66AQqTxadcfH7gkNfdnlAq1xNpddXC9W4TmNJslVgVYPrZQOU7ps007drDq27/isxb
	TAYGq8DGxzg2GgLBhgypjpZQzNHThvBcYe7+cWqoJh29So8Su0dfPo3vgB4NqTi6AygQTA4FhTB
	CT513K77ehwPgvtvU8q+xH00Nr6Mad0be0O00JICBsUnRwRBHa/cCJnxQc29UTNBVwl4PYc08L8
	xv4o/3PDH4K7rErWgtSgaRvZCmAOfUf3hDnk7VnMDH8KPpc0uwgPwghHpyKX45ScsbFYvyd26EM
	sUlu/DnyctgeLG/n53PcpNLZk5ezDieFhHrg0S21Haa30JsMqB/NI+/Bif+2DT/emjGbGgRU=
X-Google-Smtp-Source: AGHT+IG/I/3kuH0MZeGbxqTluMGA0auO0pu9OlYfyOh5h6egxRVqvJCnVFafA2Q77VjQxho1xSTtqQ==
X-Received: by 2002:a17:907:9629:b0:ae6:fa02:888d with SMTP id a640c23a62f3a-af2f9381e96mr794874066b.53.1753377638775;
        Thu, 24 Jul 2025 10:20:38 -0700 (PDT)
Received: from PC01.localdomain (094190205166.static.ipv4.heldenvannu.net. [94.190.205.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff42b60sm134341466b.132.2025.07.24.10.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 10:20:38 -0700 (PDT)
From: Bruce Qin <bqn9090@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bqn9090@gmail.com
Subject: 
Date: Thu, 24 Jul 2025 19:17:13 +0200
Message-ID: <20250724172034.44679-1-bqn9090@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025072409-promoter-shame-8105@gregkh>
References: <2025072409-promoter-shame-8105@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi Greg,

Thank you for reviewing my patch and pointing out the issue with the closing parenthesis.

You're absolutely right — the ')' should not be on its own line. I've corrected it as suggested and am resending the patch as v2.

I really appreciate your time and feedback. It means a lot to me as a new contributor. Thank you for helping keep the codebase clean and consistent.

Best regards,
Bruce Qin

Changes since v1:
- Moved closing ')' to the end of the last expression line (as suggested by the maintainer)

