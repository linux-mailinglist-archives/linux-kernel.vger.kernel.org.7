Return-Path: <linux-kernel+bounces-818507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC455B592A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2D618911CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A2329898B;
	Tue, 16 Sep 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bo7oKQF+"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6E296BCC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016085; cv=none; b=Pl+yfYj+k8T8fV/+hNIgpHTJKisSwFjweItzuGiyxMMMvHJJlZwlVgbUDArCK9qSF8kJWqtrI2GfuK9TndS4JdwwOvWoz9slRs3XZGxyMFTgFvE1HpCvkyBi6gHXW2IFn/MCXomO7jUx9oMN0kAy7xnNM1NIorrg1PX1p5p0uEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016085; c=relaxed/simple;
	bh=Xtp6rsv0we6loXr8KX7p8CjvjrdRQN0t60CzR4y0U7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izQvg880kBKa0kI0S9eLU/zq/GzfUkUpItbJrsuNCRooWx1C5pa39jR4AsGZbyN3kw5KXxm6fqUBmsFqm3QJM2XsSOenTVE+EAB9T/bo+j+70f7f2Z1hHTQlFmDe3GLtix6C0syoLgD8DApELUyBXDqbcUIttQtF934c8SI/4Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bo7oKQF+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3eb0a50a4d6so1151801f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758016081; x=1758620881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHjpXhjv6Uw0u0A/3vKysGefkTkoDLwlYIdI1qGXpMY=;
        b=bo7oKQF+hMoLOeZ0xhUC8h3Vr1QmzZTSnGRzkAQqd+cqTnQABzLNDfnx6Z3JunihDW
         JaYTkDfqPFYQeTh6+0KfENHjVAIJfwmwl2KWyivGLK5ewoudRBjiAXl+ytQ8ziFSOscq
         zCMxCdwXGMbkORGA0vcmLVlqRbEfe2NpctoAp2lgrVkQ6RG2qF5j/iokKLwdjKmI5hLh
         1RbnWfanIDYyCK8+I7pwfp9w72O4lLDHGsiEnV3iCSrqsbPVqrEEhOmidZ5FHVPr3Whe
         kjmfhRQdA9hIM/e3VdgW6QYuGT69ll3b0w3/utrrZa789gOzcrGP/RGeTYx4HDVRMEiA
         lQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758016081; x=1758620881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHjpXhjv6Uw0u0A/3vKysGefkTkoDLwlYIdI1qGXpMY=;
        b=ODc43pqciPhLEMIRqnY3VbfLMBmAWLZ4Lqf+7bre7wKMujgkrA3pgNkNbWDQaI4B0Y
         ec/Vb2gOvwXlU+au8Duic3HroLjUC/PacOYFhMLmGVSdJdMGSh+qbft6Ub2creJP35Ms
         H+EH22cvP92Jec8G5x/qdDJLS2963gsc93fey/maNu3PyXYWup7HYK/InH6wklDB1/VJ
         SzHY4O3i5vB3OGygQOluj1bPaZDNM3HUIfeMxAMK0brr3AXLgTJsUzpf1Q7X+vU85xNm
         gI/TxnfVPZmUG+aEg0pC3MVRkc7geDO/5Btt/FT9pnsSc6/xqE1EAc99fcK/VL23Q6bU
         +5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUJAt2v4wUV0XZHKFzB691ECJ1wl3YktM910f6GvhmT/NqHgnxMm/B+RSVKsqyIdT0ZCV/dhxfmqKW3oRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkDPXvyPdalctciEr/I3jRqHOBp9ikPEWOKyBqXXs8i11h+5MM
	De14ELqv1ndz1YPyzy2FJz/2bXkLIZ4yz5ocrVW+iJKlklU7Ed5c46p6DofKQjIdYsI=
X-Gm-Gg: ASbGncsLWut/vyA5s/CNuVgYxsg1hlkg8dowHJ3dUUr+Jg7CGCpLd/35xw7KyxErGto
	i512hJE/Gk2QBhB0k3yi3tSDHPSvktl9Vklc29BSoQZi9FehRHkN9bHXTdqP8Ec9XpFgs5cYJJU
	6kxqRXbcl0EqsDrG3RQhZVb4WreOHwpBqQwbD7oTqnTVaO0G0LWqck3wKNpeFTojH4jHGS2N3/1
	bqu8UxKhDLfQ9Dtt+Wl+wGvonG2/5eQXwhN6Dd7j7n/Pa42JgHD/NxAaGJpz5MBmtYDuE4Xtehi
	b2TmHMjxHd2/Xw6fTREomWLqa/bypvRwQEKvbJt8li40s9+r3bTG5pXLdkm/+Rc1O9PYXVja1Bi
	jN72P1sl58FfaVCcSQ9/6kLCPDvv/5Bu7kKnu
X-Google-Smtp-Source: AGHT+IH6+DN+2iC4Z4uhDEfr0LB6Z+tnW4YIIzn8sB9BkEp6enUX0B4DN8xSWO2nsBfkghB42HO8UQ==
X-Received: by 2002:a05:6000:2586:b0:3e4:1e29:47db with SMTP id ffacd0b85a97d-3e765a25836mr15049192f8f.43.1758016080849;
        Tue, 16 Sep 2025 02:48:00 -0700 (PDT)
Received: from brgl-pocket.nice.aeroport.fr ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786ceasm21733718f8f.16.2025.09.16.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:48:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] dt-bindings: gpio: fix trivial-gpio's schema id
Date: Tue, 16 Sep 2025 11:47:53 +0200
Message-ID: <175801606720.9656.18120314835859405070.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250912165916.3098215-1-ioana.ciornei@nxp.com>
References: <20250912165916.3098215-1-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 12 Sep 2025 19:59:16 +0300, Ioana Ciornei wrote:
> In case the trivial-gpio schema is referenced through a $ref like
> /schemas/trivial-gpio.yaml to match its current schema ID, the following
> error message is displayed:
> 
> Error in referenced schema matching $id: http://devicetree.org/schemas/trivial-gpio.yaml
> Tried these paths (check schema $id if path is wrong):
> /path/to/linux/Documentation/devicetree/bindings/trivial-gpio.yaml
> /path/to/dtchema/schemas/trivial-gpio.yaml
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: gpio: fix trivial-gpio's schema id
      https://git.kernel.org/brgl/linux/c/17628f1abbf4bd4162c655f3260d68bc1934ec73

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

