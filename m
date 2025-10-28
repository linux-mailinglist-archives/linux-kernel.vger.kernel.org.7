Return-Path: <linux-kernel+bounces-874896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ED2C1760E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137E53A48B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1317306B00;
	Tue, 28 Oct 2025 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOQPpC/m"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DEB2C15A8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761694555; cv=none; b=XGnREEiN8y3Pphe2atKSlgd/9vesrvUXyLL1PVS7kcauM4O+KUB4wRSeM+UqRy5Gjh0nmDDiNMW1pcfeNtLXGYXYdVvpVplAiCkGZwLxuoo33gUOvTCq9ps8Rj0BrNnuGhLWZ0e3hg/Zu2E9wzgoNijihAN61EdQsMHWx6PPj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761694555; c=relaxed/simple;
	bh=pO3ezBcQxEG3Pj7tMfcTswPOd999jDNlRZTd+tb/its=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3ie3IVCzt+0/E2DyM1gqdi55mFjAUC/Y6dz+l36VXTjpjZKfO/CWs/B1/XpB+hNvlS6VzrgzlYvAJO/zY9tgdtElM9zev2OC5qfVECJ02vwbzxVKxuPYr5AFy7jRRqaK0JSL6mbfQacXZI3zoTphjLCOthf5BDtTSl2wPsb8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOQPpC/m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47117f92e32so59941515e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761694552; x=1762299352; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pO3ezBcQxEG3Pj7tMfcTswPOd999jDNlRZTd+tb/its=;
        b=kOQPpC/mr/pSZI816b0Fn6HrfxFcQKig9QLpQq/T2i81OBCo/MpEQAmYLFXuicMtVW
         89179mMigsvCEkIvqsiCgs9HLyfudd/Eao4peUhWhaUkCG+GEcbS3qOvaRK+6G4cEGpX
         DovbewDH8zImjk6rpnaz+oA1WRu0TUq3otZlR6rw6rbLG1njtAJEcjWlHzFPblErCNkG
         vQZ+wIZxY5MnLupPhSOBMfunuIccCHDuhD6QaPPyMfa7ykwnewec5Jw9gXPIBjp3piqR
         6fgUgDgxqnuhFMnOtmcfRs8qVwkdEK16rW22EfU+fBRBbN5iQfgZF50LPPoLOx4X2h+M
         QBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761694552; x=1762299352;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pO3ezBcQxEG3Pj7tMfcTswPOd999jDNlRZTd+tb/its=;
        b=YcdA2GDqLS+czD7RIGZkmXSJNskUboPvsA9fWztD0iQkXaMRhfpfPDCdHvak0mOugD
         kvg82KzuK+fKqlytCJo7ge4oPDxsknefNOlK/IL4tPNAydvnKoZnyGUy2lk7i8bsnpyz
         xyBSiDbmPLXDSvTxh15phaj5sJes00J/NfMdPw35tPnHTpxxOa0V5KGi/igX8Fxi2i8q
         gEFHtO6gD+JuYxmvSPtApao0q9vuJaOa2aes10Vrd8NvFHl4mUUqov83CfgAu2JWtnt1
         9LQp3vzLVM3NRJE8/yrsN4hww/Kxq0i8/CuMNFC7ZuRKWiazS0CJaxSHYyWpnWjrIvGo
         hxxg==
X-Forwarded-Encrypted: i=1; AJvYcCU5vftqfOSrHlDCoCEfPsfDLWt0grh/91QzNsObU0YMKC2iUHwH1qIpc6tM+zjRXAPw0jAk1DNDPFZXtB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmcuINAaUKT5nw/DX0SdlMs9p85G9l2Ha0M/I9n3+de8v3QBaL
	Xi/7IWERYNqhZDrNrRu4C/vxXrSD6zNNyH8jUhxUDdSiafqSbsi0QMcyV/9Kxg==
X-Gm-Gg: ASbGncuomv2/yqcIFj8h5r3Lyqn4UHuzrBa9/dlb+iTLuP35g0rFWk6xKOUJzXedFET
	fbPl8kXB9ln/mvls0xdEjFSwpaATZwx2HDv3SB/2I1Zp4G1dsU2QT92Wmva7tEWiILlLKV4XkOj
	dkrP59L5LzK6H9PpPtGVbyqY9lTdUqhEWXAxzVTQ7fQF2VC96nx8C41FeLNB13gyQkmRoP42Zzc
	8aMgvIVpTVbCUnrvxdodWxcMIj2hNhaoPPyePlvKgTzKKbSteg4qtg6xd2Fj4mhXnoJZA9g/n/H
	fPll967pg93eWyYAzUcZGVauL04jFGCuAvJopqpINY0gr4oPV1Hzt1aE+jRMzmynicq4hQaqVPh
	gw0hsfT4LBkyhAWtrcTRDbcBJ49ZAIRKdyHThqJxm6wpLOw27GdlD9JMgS+j1cR/abxmoc3HPbw
	86pqexYbgrEnR9DBdomcSz7ic=
X-Google-Smtp-Source: AGHT+IE+7lavUcbRiUEoBcPcWWhtl2Ye0Lqq0olW9TOJGPDFy5Ml5rtmUhOJt0ianoi/OzmsyK7njA==
X-Received: by 2002:a05:600c:3b1d:b0:475:e007:baf1 with SMTP id 5b1f17b1804b1-4771e3b8626mr10555025e9.34.1761694551467;
        Tue, 28 Oct 2025 16:35:51 -0700 (PDT)
Received: from vitor-nb.Home (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e196a9asm17054265e9.7.2025.10.28.16.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 16:35:49 -0700 (PDT)
Message-ID: <f99c528a19fa793035cece3f83b332d7ecafa7da.camel@gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: PCI: ti,j721e-pci-host: Add
 optional regulator supplies
From: Vitor Soares <ivitro@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>,  Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Vitor
 Soares <vitor.soares@toradex.com>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 28 Oct 2025 23:35:48 +0000
In-Reply-To: <wg2wpwex4vbwwxynk5salk6mbpneww76wfvznn442a2xyqrrck@a7qqqn3hjzcg>
References: <20251014112553.398845-1-ivitro@gmail.com>
	 <20251014112553.398845-2-ivitro@gmail.com>
	 <20251020-kickass-fervent-capybara-9c48a0@kuoka>
	 <2c3e4bdefb306dc89c15bebc549d854ea2b4cc32.camel@gmail.com>
	 <wg2wpwex4vbwwxynk5salk6mbpneww76wfvznn442a2xyqrrck@a7qqqn3hjzcg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 11:11 +0530, Manivannan Sadhasivam wrote:
> On Mon, Oct 27, 2025 at 11:22:26PM +0000, Vitor Soares wrote:
> > Hi Krzysztof,
> >=20
> > Thank you for the feedback.
> >=20
> > On Mon, 2025-10-20 at 13:14 +0200, Krzysztof Kozlowski wrote:
> > > On Tue, Oct 14, 2025 at 12:25:48PM +0100, Vitor Soares wrote:
> > > > From: Vitor Soares <vitor.soares@toradex.com>
> > > >=20
> > > > Add optional regulator supply properties for PCIe endpoints on TI S=
oCs.
> > > > Some boards provide dedicated regulators for PCIe devices, such as
> > > > 1.5V (miniPCIe), 3.3V (common for M.2 or miniPCIe), or 12V
> > > > (for high-power devices). These supplies are now described as optio=
nal
> > > > properties to allow the driver to control endpoint power where
> > > > supported.
> > >=20
> > > Last sentence is completely redundant. Please do not describe DT, we
> > > all can read the patch. Driver is irrelevant here.
> > >=20
> > >=20
> > Ack, I will remove last sentence.
> >=20
> > >=20
> > > How you described here and in descriptions, suggests these are rather
> > > port properties, not the controller.
> >=20
> > You are right - these supplies power the PCIe slot/connector, not the
> > controller
> > itself. However, as per my understanding, the current kernel practice i=
s to
> > place slot supplies in the root complex node rather than the endpoint n=
ode.
> > as
> > seen in e.g.:
> > - imx6q-pcie.yaml
> > - rockchip-dw-pcie.yaml
> > - rcar-pci-host.yaml
> >=20
> > This seems consistent with those existing bindings, but please let me k=
now
> > if
> > I=E2=80=99m overlooking something specific to this case.
> >=20
>=20
> We do not properly document it, but defining the slot supplies in host br=
idge
> (controller) node is deprecated. Some bindings still do it for legacy rea=
sons,
> but the new ones should define them in the Root Port nodes as they belong=
 to.
> We
> do not have a separate DT node for PCI slots, but rather reuse the Root P=
ort
> node.
>=20
> There are also bindings that define supplies in the endpoint node. They d=
o it
> for devices directly connected to the PCI bus without a connector (like i=
n
> PCB).
>=20
> - Mani
>=20

Thanks for the clarification and context. From what I understand, the
recommendation is to define the supply regulators under the individual root=
 port
node rather than in the host bridge (controller) node, as the supplies
conceptually belong to each port rather than the controller itself.

On the j721e PCIe controller, the current driver implementation assumes a s=
ingle
root port and doesn=E2=80=99t parse child port nodes. To follow the new con=
vention, I=E2=80=99d
need to refactor the driver to support root port subnodes, and I wonder if =
the
PHY reference and reset should also be moved to the Root Port node in that =
case.

Could you please point me to an example of a PCIe controller binding or dri=
ver
that already follows this approach?

Best regards,
Vitor Soares

