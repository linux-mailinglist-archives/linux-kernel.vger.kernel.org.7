Return-Path: <linux-kernel+bounces-820071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C51B7DCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12BE1B21CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B122882B7;
	Wed, 17 Sep 2025 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljl/Mtiv"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465B189
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091106; cv=none; b=a49PkZ84OkxtMIW8LiPSPFP9E40yVPVb8md31B2NAUzrmOY2mJ3gGV/6RnkkG5Wux9wV5CDZWOjCVTxThaxHg7XL7wE7T9Cygu9JCdqEtNRxdr5q+W3mq4rH9t8CvfTsPf9Y1BQPontkNZypvl6KyUvUSKz32a9/q58J0Cje9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091106; c=relaxed/simple;
	bh=YYyAOVBQQtvxzPrtPJTgX3jJY+qiOrBT4+FZybWQNvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoOr1AlLO1w0QK86J7woTHa5rdIcBvIQs8/LGrgIJ2Id35IACwkKYHEomq9Fyuh/m3E1lsEuqmEATx0ykrru/MNseyFh8IljtJWyzfjt6tQ189KZ19e2Tmy2QZRyhUdCVcA+/LnVrXCIDZnNBXhsoPwTYKl1dfqLzoiwRbNAZg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljl/Mtiv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7728815e639so4432293b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758091104; x=1758695904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a6eDfP+fBc1ozuBGmtJ5qlwX2HPSbOLB5AoahUZfu0=;
        b=ljl/Mtivb0fZRK9ToJ22OXlasMRmAaeh9rZGU8rKLBYr4nfHTGPuf7LcgxVKvhSsrh
         PCycq9sh6uwiZsYOZmd2YQ/YCB8XCPatN/D//fxl7KRV95J/7GMwrbSHWYq4HFdMig4W
         c5gnMDUn3GUIt1AtP0wDxAJrLAlEXPFV45w9T4lyaau6hHuMQV5XLOoLM39hvFmx33NK
         UISGJDUoahD0hoR2BmEKpKhtRcGYmMXGDPRtjbkC+IlgQVSM9aAAmzD6FRAlhzs3nCzx
         4vsxXNxgsIvHv7mwHIqiyXcV1+oLnRhSeffJ5dKIUcfe7SWfW0vpbrcUKg6Y+fsIpigl
         8QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758091104; x=1758695904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9a6eDfP+fBc1ozuBGmtJ5qlwX2HPSbOLB5AoahUZfu0=;
        b=S5ypRpccqVv6llBxgFkZ6fxjNnPZ80Tr7BoqQONt4HP4Pp0Emp5+iuqv1onkZmMftQ
         ErJH9u+heH+TZZKxvVznVJ58+tIvzThd+K+zvVGNbFZtLbkfoLT0j2w740s3L5/BZd2M
         ZdY2/8w9iJtuYW1Kqx1CanOffvthFEHnQalF4EYgMKSWlGt4P53UGz8iD40rJZA5MTVb
         dDuRJndk2nYnPN/e54TXMP1xM+z87troxpmbIH+6Vgt75UqNQ4qmNmYvb3P3OgnGF8SP
         ruR0d+un4WMyyY6l8LrS3/d/+ph8jHi0Ftt82R80A3xxc7P2k1S9CYZvNspVSxxIR1qd
         7gsw==
X-Forwarded-Encrypted: i=1; AJvYcCW64CvZRuN837u07BLcWYZEVYRt8bg5qMZ05yqeZ6HIdFE2VX7xMTX3Qxv/BraN7bpht0zKmKJApb1H1NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4wKff4t0xjutlw6uNL6DMxtevvbmaGxmZA55+z26Vfg/oZDc
	3gaV9iDJkvt53r8mV9+nxfdekBwHbwf1h03QR+NgTDfRB57iRMP+q6UZ
X-Gm-Gg: ASbGnct/vjqeytNuF+d2QgsxuCnCgVy01NT1sQiBwqBbSlYuZyrIqksbiPoMyHIyjSd
	3JlbpgQxitgfB5p6mQODiy5zX9wkt7x5eIGM6tvn+ifBN8HHfxXD2aiMCSDC8ElEee9EBDcg+ze
	MHPjjYebCTiNsmwQBFSDTwkHaLCw9072RqoLHyuXjVTl8vOqCEbl0XdgQfFcfbq8bWBv3zxMCFv
	ORgWJunQLmwEdx3LCahvIIp8egSQbrvnHRnqS58FPL2zyfnGVVhNXZwDXd08igODpMhL7QeEWhz
	uctUQyfg6i/SAm7lBxCWOE+gV25q7Z+EZLO01/R0Z1VrInm0iAaihS0P0dCa7PiJrEMZDCuU9b6
	vvchug0ytlcdXZc4635gekA==
X-Google-Smtp-Source: AGHT+IHq6XZ5/++BtlIMzWowm21SXwFZ/EFsiRjC685ax8WDJ8CH4yI13VvPILnIiTf325I/TiMPPA==
X-Received: by 2002:a05:6a21:6daa:b0:263:81aa:d60d with SMTP id adf61e73a8af0-27a911974e0mr1470121637.14.1758091104211;
        Tue, 16 Sep 2025 23:38:24 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607a47310sm17432570b3a.27.2025.09.16.23.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:38:23 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Nutty Liu <liujingqi@lanxincomputing.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zixian Zeng <sycamoremoon376@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dts: sophgo: sg2042: added numa id description
Date: Wed, 17 Sep 2025 14:38:08 +0800
Message-ID: <175809106542.461740.14901329077964229669.b4-ty@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910105531.519897-1-rabenda.cn@gmail.com>
References: <20250910105531.519897-1-rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 10 Sep 2025 18:55:31 +0800, Han Gao wrote:
> According to the description of [1], sg2042 is divided into 4 numa.
> STREAM test performance will improve.
> 
> Before:
> Function    Best Rate MB/s  Avg time     Min time     Max time
> Copy:           10739.7     0.015687     0.014898     0.016385
> Scale:          10865.9     0.015628     0.014725     0.016757
> Add:            10622.3     0.023276     0.022594     0.023899
> Triad:          10583.4     0.023653     0.022677     0.024761
> 
> [...]

Applied to dt/riscv, thanks!

[1/1] dts: sophgo: sg2042: added numa id description
      https://github.com/sophgo/linux/commit/4d94abded400a5194b929c26b3aa07fb9485fe35

Thanks,
Inochi


