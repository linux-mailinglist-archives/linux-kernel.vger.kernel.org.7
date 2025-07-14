Return-Path: <linux-kernel+bounces-730486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D254B04563
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA261883133
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC26260562;
	Mon, 14 Jul 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPlAQsDB"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5260239E90;
	Mon, 14 Jul 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510097; cv=none; b=SAPPuf+ppsXn4rlKOgckBqXHUaj+TxJgmz9vktCZsAWHu/l4CkykJkLuqrEG0iFtgRZszzQuTQetuiejA3Iq4t5d4xL7v9PMusKbIWEs0y0IQb7he9YGdpdhllajnrN+Xv+YTVp6OVXF6SmAYVqbylvu5eCdUGFQSjC2qxxoVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510097; c=relaxed/simple;
	bh=XjvqmAKiMsbfWeDFcAZa4/uUI+i93E+juUAjbGkwaZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPSFarXjrQf4HyaBNKcwMcYvcjEz4Ryx8M/HbTu0BQYNH4ZI/axyNB8VasV2Z/mbYgA9F+rJgvZ6aD6Z9UWGeVVFxK23o0GaYO4miGxUkZNy98rkLUzC8WYtdmahYry/pfdN6yV00Bxjt+8nYhAxp3aeipxWO62ZhRwUiJzDBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPlAQsDB; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso5016239e87.0;
        Mon, 14 Jul 2025 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752510094; x=1753114894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTJbJuAYewCnYP85dvVNBBoh8mXQ2CM52g5B5kBZ2H4=;
        b=bPlAQsDB3ZKCTfv61/kScUV7k8BsGVV8Kk5o6XVoPki+H2TmXeJP/vDA6L+AbqYNf1
         YyXUuuHLci3cOTPZzlGe6gtb5Tf0ekehogs+a+/xlQODINHIGAcqxxJHAMhDwpIBx541
         Epb2+SGTcIpbwKAOy92o7xjctxXFYLi9WzlHKJNGXeu4D3CQBHqb4fu8JkIMAVOS81eP
         j4q4enQYd57p9ARtXjtIdtM83vU5Hf2r3QpES+DfXI2CG27GSdllbx6qAFhjhv4fZ3dT
         9PQAzCYwnUpV1g81Yg+FAPIdXtPtYFkh9jKKWKOb/bGL9wrIzAAngOQ2GPPTx6KKTWsN
         wPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752510094; x=1753114894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTJbJuAYewCnYP85dvVNBBoh8mXQ2CM52g5B5kBZ2H4=;
        b=jkMoTX5V2pd8C3pGgAGVZbRlqHvzkERlvVumLXAANUcOysmpF9tbShf+HD7vS+l1zx
         kHC0QbApGXg54WW6dSiBoWj5Ondg4FahYvMqKIGDA+ewZq3m5dwKHdsOOZuLOWZePKsH
         P7Kbf9zy+HwlWrKVzzRkrvir+TguPESJdTdQdjdQQR6k84cessisGlnbRhQXHKMbznrB
         ufz/WMIkqbvwrGd6XuMo1Rz6pZB+koX8rQVkO2FTz6Wqse9bZI/Ho0sbdm7d7w6ayCDF
         2yhrtJEx8mV6PqGAB/4YZ+rzMONkaZ3WrUg3lFXWrtmTujlr4dmD0/nZQUvpk84UmVgd
         agng==
X-Forwarded-Encrypted: i=1; AJvYcCU7eiWLm2+Bh9wRMiKc8nv8+oG6xaHqYXC+67j5ihrk/jiellQtIZdJwhK1SU6lHcBdMeKa95Dg0BOzL7AE@vger.kernel.org, AJvYcCXRq1PI29QO1TUgyv0cjwi5nTEK5bFtx2MF1t4RJTLeNq6ZRtg0VxWi66GHcwUfVKL2fF2z25qKnDZq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx70u4F1O03cTbzkYap4e0rsFzjN4zVvUD2VFn5oz5WHjQ3Ofgb
	4ECssS+TmLttTfS9c2oFicOoipyXHrG41yF7ZM8CZdluubpIhYqw33S1XD5m47cKukODVAF9T9s
	b6TXbfjJkMN9TFy+RX5bptHa3dOsy4ho=
X-Gm-Gg: ASbGnctFIueEFG81CTgsxkenZidlpE+ZzRI1mlgfF5E6hHydHDCNRRJ5Wn36Mm/7JoU
	6kNJ4ujogGU9MlI/XmUkBpToI9yiObqWhjMfq8qB3OJUecyAjcMqOoP7Fg+kbqKqT11GopB1Qdd
	5kWc+RaoKf5ATWm9PuU3m1Yd/ZcpjY1vRQHqLyGHaEsouvAHJ5uZzil7/YmzwemjvT/OBHsktzg
	fEjYydmjgIV3IawA1rlGMJJ+3G+g/ml8lt20z4=
X-Google-Smtp-Source: AGHT+IGclm87ydSL49+QzinPSsQrejdcAIdA+dUrBjk5YaRkXcD87gn+2kE9WiuvkWEf0ylhE8sXm3berCKC28FI1hk=
X-Received: by 2002:ac2:51cd:0:b0:553:2ca4:39d3 with SMTP id
 2adb3069b0e04-55a04648aa5mr4435881e87.48.1752510093600; Mon, 14 Jul 2025
 09:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714141852.116455-1-frieder@fris.de> <20250714141852.116455-5-frieder@fris.de>
In-Reply-To: <20250714141852.116455-5-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 14 Jul 2025 13:21:22 -0300
X-Gm-Features: Ac12FXz0bznvDGRsXPKyEt2xRl2QsdOW2ikUFXHoPrhlON9BuiFs_wNXWUtrWMc
Message-ID: <CAOMZO5AR_6wODDES4ojA0KYmN7jcxuWgicuKBN+hy1e0EE=yiw@mail.gmail.com>
Subject: Re: [PATCH 04/12] arm64: dts: imx8mm-kontron: Add Sitronix touch
 controller in DL devicetree
To: Frieder Schrempf <frieder@fris.de>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Oualid Derouiche <oualid.derouiche@kontron.de>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 11:20=E2=80=AFAM Frieder Schrempf <frieder@fris.de>=
 wrote:

> +
> +       st1633@55 {

Node name should be generic: touchscreen@55

