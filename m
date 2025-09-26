Return-Path: <linux-kernel+bounces-833482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD31BA21EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC29A2A7CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAA3187346;
	Fri, 26 Sep 2025 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL9cqrrJ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481A1527B4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758848687; cv=none; b=osfAkCigXVruIuBJ2tq8WYAjMIPEt8npP7Mda1XSJX/4k55B4Rc5p8ETcD+JSUriVbCFn6oejyKuYAR/bl0KcKM5Mjw1W6fvKz2FvtUGnvB1+gZ9Kjimht0rFOLRD4NSKbFeRzJADzT5zUUi8m37CmZG+5Dp7en2u3hOizCx7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758848687; c=relaxed/simple;
	bh=f+H/QQJgKpGK4WSE+pqHlhBqTQJ5PHiZmCPRBD6StTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFhfKQwy/oT/tEnhpOMteFyYrD0qU/l8lI79cbirUTBx9SdhBEuVjC100+1A6DpQSAJht81/b2oK+1WMlobYfPaUOoGfUtYtRnHiHg60rNXEyMAaVLkoikN8hzYd8Fteo1aONT+kT9MazwXHpgOuHjOOm/15tjuwZqT1WbIBQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL9cqrrJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-367874aeeacso14640651fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758848684; x=1759453484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1PTcenWwYJQDqIWAGafXJtH7Gx1jBmVYXi2cXCmKlM=;
        b=jL9cqrrJGrSo2ku1ShXclnuHd0PGq27zuWZz7yggPU5JmDghsVM7UkqHmJIXwcj7ZF
         aEQml1/Zy9f2rZc+knDDKfRgUZUI0q/p5imwEOiyZEQoJWgvGwDT18k6Ve3LKZREPH+b
         4KzrUdnYYtDN5JlhyYrLe6Q8MveZ4tbj1zBtNnQdm8xaikyDMTcf5t3UxZFP2jGp/4RZ
         1EaWKiAMt3t3O2N4+kVtU9/YZHaRuztITYSM9BwaX13Ue+rnRf1Hxmn97sdgAwN3S3Wd
         SxQIhjOoiIyu1oqKCHX770An8fIaD7VxTbiqPbBzS2YRu6bSKX5v/8pe/o+X1sgikBzD
         jANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758848684; x=1759453484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1PTcenWwYJQDqIWAGafXJtH7Gx1jBmVYXi2cXCmKlM=;
        b=IFtacG9P9vvEkjAsGra/7E0fdPUyZNUFdShNX60k4OB/gQ7sMPBFLxHUbepZiMuXEP
         gaEfI/1s4C8kQUtXwnJJlOqcEjx3Nagq/0EqEJg9Rgpduz8K2B+ieuyArg1+ICa6+DT7
         uBb7R0CyZRNtpwxaf0iKANWlQs9CxGTVicXGjCwBZqmzannHi+eUnI8k/v191EBvBPFQ
         FGB6gs8w16dm7CQRO1XZC2Tq86L9U/K9pu4QGzrtkQ4qQT0en70TqtYxY7WpNkb7JJZn
         3tC3xlr08aEEO8T1WOj671mpENCIawyq2Kacp3ONF6PS0ZiZqrEcAFsYflZFVxW5hEx9
         QqkA==
X-Forwarded-Encrypted: i=1; AJvYcCXmt2B7xthlJCmajVHaxImTOjOWvHdqbpgnQhr38/0zwpPP72bUbADoioQ6CY6XoTooFvs66EahDtABXZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOXC+kJ1NmxTSNpFtqlm9AZ6kq1R2F9JjFackjpEPo/okINUL
	9PrTQfTr0MQo45AQTifB4Neo7TtMSBPJvPByrNO7vvMHtk+RUlQ5vHu8Fj3aGs1jMPFbgvOnyXZ
	QquTVQ3tEHny6S6F+9EzOcM1lLlEoouQ=
X-Gm-Gg: ASbGncvSHEAin5yFfrxHf21ohITTcp/Y/QZAW3eOGZ/sLnfnyKhi6PJkuE3eF7hu386
	5RbiWPyBMlUWPw/shcD7YhaMnCcm9QeD4tGM4bZoQa8gzioY6MkoIXouKalRfTi0dpANt9an+pT
	cTsIXdImiLL3sdAdHlvEmM4gnLCRVz/ilcwxhy4OrqGrnYE+0qfhVV3d8NLu1I3LPxdQShc5vdY
	R81sMoIKzqvhj8xhgv6JSC8+oTn7zip3oZAqLg7160yHHWzqQ==
X-Google-Smtp-Source: AGHT+IF60TM5C+nAEavr2hjyLt4InfjHbymmnuKiT3q3qe2EKbyjz8AweucVXMC9Vaf26fmcfOScUPJF+Jt3PPMgBJU=
X-Received: by 2002:a2e:a54f:0:b0:354:8a7:2f7a with SMTP id
 38308e7fff4ca-36f7f2489cbmr16533621fa.20.1758848683520; Thu, 25 Sep 2025
 18:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com> <20250925-imx6_dts_cleanup-v1-8-748380dd0d22@nxp.com>
In-Reply-To: <20250925-imx6_dts_cleanup-v1-8-748380dd0d22@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Sep 2025 22:04:32 -0300
X-Gm-Features: AS18NWBj6BcwvJ3vSrAqizOdTksjhpkILyWLhm4qyX1--PNMSLiRuSdyQPA3LCc
Message-ID: <CAOMZO5BVbm+Vh=XOiR9peP0oW77GiqaSNCbawK_j2+_-vFj7mA@mail.gmail.com>
Subject: Re: [PATCH 08/11] ARM: dts: imx6-tbs2910: rename ir_recv to ir
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 6:14=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> -       ir_recv {
> +       ir {

ir-receiver would be more informative.

This is what gpio-ir-receiver.yaml uses in the example.

