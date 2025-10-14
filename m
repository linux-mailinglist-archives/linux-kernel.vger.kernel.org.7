Return-Path: <linux-kernel+bounces-853240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CB1BDAFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF0654EC30F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B842BDC35;
	Tue, 14 Oct 2025 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op5ZR0bJ"
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89C23D7D9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468697; cv=none; b=QeI1eL8dHXFCSg0sPYagazM0JCw49pPrVGtNQTvjmCyR4aMW2LgqTanSCiKxg4vNKsa+A85qNyD5WvrYrpy51t5JUgewZbToXZj8wbsG0O2qy5HmHFQN7owffd+QFcYrNQoCdm31QYzpBT/UBB0MxjckYNs+Scw5yivLsNq2Jp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468697; c=relaxed/simple;
	bh=N0AeLKKkCbDWNM2GHj2h68g3QkP1HDjh2+4qJG/csDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEUt3p9Z8KgfTB0ZIR1Yx5dXzPqGRslOO84oXyNy9ErPrQp/HOp0Zz6SFHjb7dG+vIkwstr3LgJDBqLMNYhqQmJKeHIh2YOCNlxBbH1HOVjVq7lI3DHkO93pAYWYIUYEUbETnOQrjAbwbvT48T4syFqcjL4n2Qk4Cs/6ajYjwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op5ZR0bJ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63606491e66so4275873d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760468695; x=1761073495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LFWIwNcJTb0LbxCmM/QhGZd9SB3ddKyXhVeoMfh/Zo=;
        b=Op5ZR0bJrteLhX5O67vCItpxZDTwSSOtkbnvcjwLkSeyv3O+jsTvH4rj8yUv9PESCX
         brGiAQoO8PQcWo/Ky6KlmN0+tNi9XRA5F1tTe4UKE2b7NLfHGmdENrF9lhBVW0EKIkAA
         axc3S7g5lvRTvCs6m7X1tiy6Ojcn/nUCyVAJkLicQt241pzYVZkOCTruKA0IPCQdgOiC
         maUdKcELwKS5wv7JxMQDV4z3YjcMDkfj/7/KFYPrIqFRI88SzUpGieR4Dq2IiPu0V2Hs
         qjrwd2m/PrldMC4aX1Cz+kXvCG53wAYevIV5bMcfBZbW6qJHVjkXxBTZNeZnyU9MSsx/
         AVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760468695; x=1761073495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LFWIwNcJTb0LbxCmM/QhGZd9SB3ddKyXhVeoMfh/Zo=;
        b=iIPnkt5rupFh3Nc1c+LUo+k8zSko2a9VqnUYXFq707jTVgUmQkTiPLhTh3HvrCes4t
         x9FWVKB4vVauPn2LD493JSHK+WfLZKSbNBwd9rqJIG51lEEA39yJWT0dDW18ouBjEBUa
         AxXejX483LcKcJcVet3S7m812G0PBBYPSQMumFv3vliaYP3xJSc6hNci0EBCOwYkf+Gy
         +V7WHZzPC5nEiG3dkOurp4O7eOArTHAubzB/spvDL9eNHZzDaa15WpfI3mnEntrbPXaM
         befLj9h5WypCKminwK2lyXqHRNcg+fmcgG/VgS54l8pJ7AEzDLx/+U0qMFidlLGU/kut
         4fhg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+6zL7Y89xRW6Y18xTgk0+8vzYHW2DXwE7w8iyhsWdKl1Vj24+41tMEtaoqlY4JGHBSRZx5dqfB8ODQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6KT8Kmkc8eKFjEKQrNNgHhUqcvCAwfmzmBiSb9edtpJ26Mnd
	aaZvWHu8380ai3JvWfZVR8HOFsv+KXQqxBAN8Ddzqtabs6+jhjHn9JdklpsfEjlFUYgy1KSUvY+
	+ucYS917WL7cG1fTfuzIGCLqQrv7RpAc=
X-Gm-Gg: ASbGncu0OQGRDMbtsJKVRAjj+DFdJQ7a0i3ulOwnk4bK/0eTOImV1Xr7mK9Pyp0AqcG
	td3WabZfUztrxLMqKuqn0UzmMPiY6uEGTECnvWiEvJAiDUuSfoQvBmpxmWs2p14uwplZ00lowkH
	8q0a7RMBEqETyYe7KTBAiTUlsVUhU06wpxp903tfUbhe6CqjW1RSnWTAR1p8ayJvjXm+sVHrtTw
	fi5usqt9Vico6fisb92buRs
X-Google-Smtp-Source: AGHT+IENp8MGH0xB25fjWT8oq2mwyBPcuUqJct7YWr59h/VAdp+CaWyYdVq+xLcQfadKFc+RgdG15n4qfGSudatVgQA=
X-Received: by 2002:a53:ba85:0:b0:633:a326:3b07 with SMTP id
 956f58d0204a3-63ccb8d82cfmr16411233d50.24.1760468695058; Tue, 14 Oct 2025
 12:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014044135.177210-1-ghatto404@gmail.com> <20251014044135.177210-4-ghatto404@gmail.com>
 <e114504e-4bdd-46b9-b708-8eebc3075163@oss.qualcomm.com> <CAMQHOhfjsi1L+3j3TrcjEjPp3xkn94KOdsrVZvJCyUDFBBSeqg@mail.gmail.com>
 <d06a254f-bf54-4bdf-bd09-3ee5e5b31bad@oss.qualcomm.com>
In-Reply-To: <d06a254f-bf54-4bdf-bd09-3ee5e5b31bad@oss.qualcomm.com>
From: Ghatto <ghatto404@gmail.com>
Date: Tue, 14 Oct 2025 15:04:44 -0400
X-Gm-Features: AS18NWCHVKoCQ2wy6kKDp8pC-T3MMcjTx0pmcrDz7hEAH7pvV2HDWmC4HnxPwl8
Message-ID: <CAMQHOhe=WYhtsjHMcRnJOi8UhnNNBfveTWRGSZ_bg24gFysAEw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: r0q: add touchscreen support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 11:18=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/14/25 5:10 PM, Ghatto wrote:
> > On Tue, Oct 14, 2025 at 7:01=E2=80=AFAM Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> wrote:
> >>
> >> On 10/14/25 6:41 AM, Eric Gon=C3=A7alves wrote:
> >>> Enable the ST-Microelectronics FTS2BA61Y touchscreen. This patch
> >>> depends on "Input: add support for the STM FTS2BA61Y touchscreen".
> >>
> >> The second sentence doesn't really make sense to be included in
> >> the git log
> > I'll keep it to the cover letter then
> >>
> >>> The device has an issue where SPI 8 (the bus which the touchscreen is
> >>> connected to) is not working properly right now, so
> >>> spi-gpio is used instead.
> >>
> >> Some Samsung devices used to use spi/i2c-gpio intentionally, also
> >> on downstream. I'm assuming this isn't the case for r0q.
> > It isn't, the device uses fts2ba61y on the spi8 bus - I hosted the
> > DT at https://github.com/ghatt-o/ss_experiments/blob/main/r0q.dts if yo=
u
> > want to take a look.
> >>
> >> Did you enable gpi_dma1, qupv3_id_1 before spi8, when testing
> > The driver probes, but it fails to recognize the touchscreen device
>
> Could you post a complete dmesg and the precise DT diff you used?
https://pastebin.com/QkYa8nMp (android dmesg) mainline dmesg doesn't have
any relevant information other than spi/i2c probing, however, I've noticed
both on deviceinfohw.ru and the dmesg that for some reason the touchscreen
is on spi0.0 (even though DT says 8) and I'm not sure if that means it's on=
 SPI
but on a bugged out bus or if it's really just spi on bus 0
@@ -85,7 +85,7 @@
         * is used instead.
         */

-       spi8 {
+       /*spi8 {
                compatible =3D "spi-gpio";
                pinctrl-names =3D "default", "sleep";
                pinctrl-0 =3D <&spi_clk_tsp_active &spi_mosi_tsp_active
&spi_miso_tsp_active>;
@@ -106,7 +106,6 @@
                touchscreen@0 {
                        compatible =3D "st,fts2ba61y";
                        reg =3D <0>;
-                       spi-max-frequency =3D <5000000>;

                        vdd-supply =3D <&vreg_l8c_1p8>;
                        avdd-supply =3D <&vreg_l11c_3p0>;
@@ -120,8 +119,7 @@

                        status =3D "okay";
                };
-       };
-
+       };*/

        vph_pwr: regulator-vph-pwr {
                compatible =3D "regulator-fixed";
@@ -134,6 +132,10 @@
        };
 };

+&gpi_dma1 {
+       status =3D "okay";
+};
+
 &apps_rsc {
        regulators-0 {
                compatible =3D "qcom,pm8350-rpmh-regulators";
@@ -280,10 +282,38 @@
        status =3D "okay";
 };

+&spi8 {
+       spi-max-frequency =3D <5000000>;
+
+       touchscreen@0 {
+               compatible =3D "st,fts2ba61y";
+               reg =3D <0>;
+
+               vdd-supply =3D <&vreg_l8c_1p8>;
+               avdd-supply =3D <&vreg_l11c_3p0>;
+
+               interrupt-parent =3D <&tlmm>;
+               interrupts =3D <46 IRQ_TYPE_LEVEL_LOW>;
+
+               pinctrl-names =3D "default", "sleep";
+               pinctrl-0 =3D <&tsp_int_active>;
+               pinctrl-1 =3D <&tsp_int_sleep>;
+
+               status =3D "okay";
+       };
+
+
+       status =3D "okay";
+};
+
 &qupv3_id_0 {
        status =3D "okay";
 };

+&qupv3_id_1 {
+       status =3D "okay";
+};
+
 &tlmm {
        gpio-reserved-ranges =3D <36 4>; /* SPI (Unused) */>
> Konrad
Resend (forgot to reply all)

