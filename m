Return-Path: <linux-kernel+bounces-872773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC5C1203E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFC23B816F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD832E6B5;
	Mon, 27 Oct 2025 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZLEYKlS"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB232ED2B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607353; cv=none; b=tSZqNMXk79spEGs6L5XFz+cxfd1sVDgmUZ4ikyWqcXEv9mBsgCeoAtiJE9vHIEgREthhiGMO+vgM1Qp49ko+yLjAWU1NqDQLnHNR6juVPe63gawi1hVmv/Qu28b6pZxto5KqHfXeBp8cORG1bYBIX/wBCUw8/yZdaEwnMa/U99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607353; c=relaxed/simple;
	bh=mJWc8tuamwRvKBHwqvZqDIpGBJpXDSGuAbIa52ymKvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YjtOIYUGL2dK99EOBeOGcRc5auzHHSYnAyYJw7hvEkjmfmVkNiNjnRPW+TF8a6FoK0F+AGBMYUxUHZXIpFmDxAcifbwdJVfu2s647eGmWRr6q78/QFYIE9Z4ZRBME6jj2NsKX995dLX7aKpDQwVRZBmEFdHYDpZHCfe77DIaAyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZLEYKlS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso17120665e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761607349; x=1762212149; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mJWc8tuamwRvKBHwqvZqDIpGBJpXDSGuAbIa52ymKvw=;
        b=gZLEYKlSyaY7U9LEWIi47p19Q9/JOhfXOlb4Hdw+HXaZHLdu1LYjJvDkdaFXCk7XBU
         ZDrusxMzNEAbTalACjyz4XWHZ65PHNsDDYdsR2GYD0WyNc1+8UtxpMF82gJwoHnPU+G5
         5PdK0yOdmjWeQGhahsllfnBXrWTb3QkzbS7udTfBvUHwXv5lZdrWFHkEwidZAb+mbicz
         a7FCABirZVq6Ib3D1aLmAIjiqz8XMJX7THpALho+rA+H+SLNYMMJAMMNwiuMJaOatZ+W
         k4MscIy/Yh+TID/wg6A8Zhd61HkCVvxS+YR7giXlnsqdE9Z5zTTo3+acZGCsm6SnAmqg
         0jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607349; x=1762212149;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJWc8tuamwRvKBHwqvZqDIpGBJpXDSGuAbIa52ymKvw=;
        b=Cc08ye+oQdOLVj34TNVW0sxfsRn/07P9hdxygCFlzovkXOIQkv7JiqO7HjJt6widjn
         ha1XOU1o9tEJPbt0jE2+lpt8IATJ2fQdRz6kHvsneD4irGaQy3YgNns3aKJxd5HxqJ5d
         iYxK3wfhX+9KzDnAQQexMQtyx5ftY3NQRN3SFRDuxkmAx5b9x1BNHDZ0WMeFzVycd5gB
         I1m1cvuxVAEWSvA3vmnEzZH6/e3kZVlst7ZX4ewIhhDza16lcefDlySMZeC2XSWo1iAW
         f641QfnPj3VbmW8yG+2QOlFNiE/LK8r9LR4qPEH9k9i/O7Cr73SKhQOWMbx2JZAalfEC
         MSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtST7CnhnwLJgCYWEQWdNc572CvsYzH7ClMzW9xghvzpJ5qxE9efVlRy/HLXGKJ2Ns50sQcypo/Xbo+is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGVvQqqxAAu7pUpHYmFwox91bFMTDaRIqDWb9wqbQ3gesHVSvG
	vVMaqzgxVDsYhjUySVlX0I8gz+X6TloxKXvEbWhkwHR0ht7yF+Lm+pGA
X-Gm-Gg: ASbGnctXn3NnYi2EGSakPTExZbc9pdd9+DN0x0SUGHIhJy99CJ4PPiLhqnzcFLnINyV
	fxD1KAvKta3RNTldxcwZPY8FdkfG05Gqk3BRuL+MS22aH35URTtHYV/bUeEQb1QcXHFKaoZxMWQ
	+bsNGQZMOO+bo7pQ05t75Wi8UumqYosx/PWtUkuRyBcNThbNGSUUIzpFhlYU7lrZGnaezkEodJc
	PGhwu/SxNf/be81VoozrfVD9pwFEii0UztiRwYhU0PHCTExXyjjWgoEKvRoRWcluFhAuYZJyQGH
	hEq2SQYfmg+iddpk6Er+nu6pNNlHAmYdH7uA2tWfF9IqyiJkmFATZOBIIdwjxdQqhUsucsKGQE4
	UH8WTWzUUeffkAngDI8pGOSlIHGDUP4B89p4hG5tXrscUZmTzf0bNMAc3zQpxYKUqsRK2rSFDk+
	rrDCXMmx1vRAE8zS63uWciAnA=
X-Google-Smtp-Source: AGHT+IGTSUIpvShoog+TN7Pzwlu9mDf4kFChPIBSClN9rsKLNQK1m4VTu25fdbNyZoOiI5cHKpmkOw==
X-Received: by 2002:a05:600c:3f0d:b0:46e:3f75:da49 with SMTP id 5b1f17b1804b1-47717e7a69amr9320825e9.37.1761607348617;
        Mon, 27 Oct 2025 16:22:28 -0700 (PDT)
Received: from vitor-nb.Home (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771900dad7sm4540145e9.6.2025.10.27.16.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 16:22:28 -0700 (PDT)
Message-ID: <2c3e4bdefb306dc89c15bebc549d854ea2b4cc32.camel@gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: PCI: ti,j721e-pci-host: Add
 optional regulator supplies
From: Vitor Soares <ivitro@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Vitor Soares <vitor.soares@toradex.com>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Oct 2025 23:22:26 +0000
In-Reply-To: <20251020-kickass-fervent-capybara-9c48a0@kuoka>
References: <20251014112553.398845-1-ivitro@gmail.com>
	 <20251014112553.398845-2-ivitro@gmail.com>
	 <20251020-kickass-fervent-capybara-9c48a0@kuoka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

Thank you for the feedback.

On Mon, 2025-10-20 at 13:14 +0200, Krzysztof Kozlowski wrote:
> On Tue, Oct 14, 2025 at 12:25:48PM +0100, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > Add optional regulator supply properties for PCIe endpoints on TI SoCs.
> > Some boards provide dedicated regulators for PCIe devices, such as
> > 1.5V (miniPCIe), 3.3V (common for M.2 or miniPCIe), or 12V
> > (for high-power devices). These supplies are now described as optional
> > properties to allow the driver to control endpoint power where supporte=
d.
>=20
> Last sentence is completely redundant. Please do not describe DT, we
> all can read the patch. Driver is irrelevant here.
>=20
>=20
Ack, I will remove last sentence.

>=20
> How you described here and in descriptions, suggests these are rather
> port properties, not the controller.

You are right - these supplies power the PCIe slot/connector, not the contr=
oller
itself. However, as per my understanding, the current kernel practice is to
place slot supplies in the root complex node rather than the endpoint node.=
 as
seen in e.g.:
- imx6q-pcie.yaml
- rockchip-dw-pcie.yaml
- rcar-pci-host.yaml

This seems consistent with those existing bindings, but please let me know =
if
I=E2=80=99m overlooking something specific to this case.

>=20
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> > =C2=A0.../devicetree/bindings/pci/ti,j721e-pci-host.yaml | 14 +++++++++=
+++++
> > =C2=A01 file changed, 14 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.ya=
ml
> > b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> > index c704099f134b..a20b03406448 100644
> > --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> > +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> > @@ -110,6 +110,18 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > =C2=A0
> > +=C2=A0 vpcie1v5-supply:
>=20
> How is it called in this device datasheet (not the board schematics)?

The TI SoC datasheet describes the controller interface but doesn=E2=80=99t=
 define these
external supply rails - they are board-level regulators specific to the slo=
t.

>=20
> > +=C2=A0=C2=A0=C2=A0 description: 1.5V regulator used to power PCIe inte=
rfaces,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 typically present on miniPCIe slots.
>=20
> Best regards,
> Krzysztof
>=20

Best regards,
Vitor Soares

