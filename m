Return-Path: <linux-kernel+bounces-895917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A3C4F443
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0538D18827DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BAB3A1CFC;
	Tue, 11 Nov 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJl0QKNY"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39F3A1CEB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882594; cv=none; b=EZLIfj7Nrlh8eB/wOdEXIKxhpBd74if77BSZV4vUcQ1CFRlutWN6aRQEd7WvTWm+lTL3ehjQgRky9lmMGoa+8pKimEoyNTWvWaAZfW+wgK7ixDxknw6WAA/GjPq+qeQmIu9Iin6D6KWJe93ghSRffEvg3wifhkTUwAjm6Q1hsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882594; c=relaxed/simple;
	bh=vOc9u0ifJOE22kl9LSphb/7K/XG0vRAottAKc6D5Sw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/IbsM2pxFKC2d1l/anenMZNsOqBBxccSpwc5xBbBIbty3m0lO982Y977p2IiMpQdDA7yMHKqnQlCJoxXfjWv2LzgOSSVBD1seKW9HmiA77aiGSbi6u5RMtxDPEiZ3YQj8LOGftA8//kTD4T7D967JkTnKRZSBNXZNkWllSddm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJl0QKNY; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7866aca9ff4so46992757b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882591; x=1763487391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XA6PWrvmc2qJTM9ZYge5OX+9jDQ6u156WMpzW0/z6Is=;
        b=QJl0QKNYGTTW9UrDvvcfK39Uo5UG/t5PnGOO5n7Xw1XKeSMdx9zr471drsF4yVltcx
         uBfGSMVf0Y0E5hrm/LilBw6ZypLZgo4pAKNFfkxfOSPhCuQXL7vEeAVSaL+ch853fulX
         1gysxl7FbElP39+gapU+LAUOOlvkVliAIY/JyHbxn2Cvg7pUEAoDfvTdK6obGPZTByrj
         TLhkVLZ1jSTFnRBltRz4shAZWEvI0kXfcdrY5TrNsO6L4gvicliQOEbxwEHjTizuG9g0
         s5d+akTX0A8kkEtfM544v3XT5itVHSFOrgjX/Zv/WOJzcuEQKN3RR76wR1vRGZhoGzrP
         cN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882591; x=1763487391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA6PWrvmc2qJTM9ZYge5OX+9jDQ6u156WMpzW0/z6Is=;
        b=CECWf6+G2FjM8FwJG2KsFem9hr9g/dJim+qfkp9Q8EAqlNdLFEXslJIyDruV5L5KPJ
         JgJMYtksi9OIJ3zKdcBTDF7eWw+g42VAV6Iy95aeza9HoZFzhYicSiNM9bHAdaOGcS15
         vXI2GxiPS8r7/kT0pOjHTMcAUKUFsfPBSPrQaYe/FAEFwSANKzfwOkKga61qYa/MYOjx
         C90iKgj32embiWMeZrnpNhF20YdvYrUQA9RxJRjtHP8cI33/Nxc+GKcCyJVDrHjGbgAJ
         DSZC/cQH+Db4bte5q/bNVAurxq8sfqP115zUma9K1atxI9GhzXq3cWr8Hr8REfG46+qr
         VxKw==
X-Forwarded-Encrypted: i=1; AJvYcCVUF8g2PhJV4ScfIOnFAJ2Hj3cNwgdGnrLidTalhzXBNlCGbFWVCvckx5KmmBrKgur0H+Ent1lbAGXMAyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvb5xijtZt+AOOD9LebIsf6P81HBJQtM6W9wegSxQLEC1hTpqB
	yweggW9FXz4Q5xRCYyEPfPmkTkKrsY8SSNMoU0/MEFZYiKnJ9szBV0b+YTTh7D60vnMxWyo3gH0
	dbVm5hWLucQ4r1j75MQ9V1lWPyHOnju/J4bmhhBEDu1i6AifdW919
X-Gm-Gg: ASbGncv8+Wr3ySQEpiLdkl+KUNEajXpYiotpCcoSBCd4gII31iSDkYIOnFvGzKEDwSw
	LBsnMwwGcbPwON8ZwU++afYhXvxv1RuQBR4XIWjhA1tCA/5BCX0zEfxQagdZPHha2Fb5XN+cQn7
	EvaQlp9NGAS3MlqV3FH46MFnuAEe9Cifn0lalTPlWNu6fZrKkwHuuOH4QKNcXhvW7vFDQCRqVlg
	qjBfQUsR1p72Px4PNyyHD6/CS3f3/kgraoZje2h94XIER5rHnu9S6G5NATQHw==
X-Google-Smtp-Source: AGHT+IFNVaNbyyI9YUCZqsi828AI+F+MYdjRQ++XqTpUuZbXJWY5WboMaw0TgPaFbEee0tq1969Cmn0SJICLTOWw/II=
X-Received: by 2002:a05:690c:63c5:b0:785:cecb:4b1e with SMTP id
 00721157ae682-787d53a55c0mr103518557b3.25.1762882591012; Tue, 11 Nov 2025
 09:36:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019115133.300-1-hehuan1@eswincomputing.com>
In-Reply-To: <20251019115133.300-1-hehuan1@eswincomputing.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:35:55 +0100
X-Gm-Features: AWmQ_bnmC-WTBpmAclXDFzsTT0R9r0mpppDTN3wHQ_0AFNXKLKQGislbIpF3PPo
Message-ID: <CAPDyKFpoLNeNgKjLcYEu1W40rOOp9mgrbM0gpYmZp-NO4ckzFA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add support for Eswin EIC7700 SD/eMMC controller
To: hehuan1@eswincomputing.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jszhang@kernel.org, adrian.hunter@intel.com, p.zabel@pengutronix.de, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, 
	xuxiang@eswincomputing.com, luyulin@eswincomputing.com, 
	dongxuyang@eswincomputing.com, zhangsenchuan@eswincomputing.com, 
	weishangjuan@eswincomputing.com, lizhi2@eswincomputing.com, 
	caohang@eswincomputing.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Oct 2025 at 13:51, <hehuan1@eswincomputing.com> wrote:
>
> From: Huan He <hehuan1@eswincomputing.com>
>
> Updates:
>
>   Changes in v5:
>   - Update snps,dwcmshc-sdhci.yaml
>     - Update description for eswin,hsp-sp-csr
>     - Fix eswin,hsp-sp-csr property structure to use nested items format
>     - Remove unnecessary '|' symbol from description field
>     - Wrap description lines to 80-chars
>   - Update sdhci-of-dwcmshc.c
>     - Remove inappropriate Reported-by and Closes tags, as the fixes are part
>       of this patch
>     - Fix error code return in eic7700_init() when syscon_node_to_regmap()
>       fails (return PTR_ERR(hsp_regmap))
>     - Remove unnecessary clock disable/enable operations when changing clock
>       rates
>     - Remove unnecessary parentheses around ~PHY_CNFG_RSTN_DEASSERT in
>       sdhci_eic7700_config_phy()
>     - Update misleading comments: change "SDIO specific" to "SD specific" in
>       tuning logic
>     - Fix multi-line comment format
>   - Link to v4: https://lore.kernel.org/all/20251011111039.533-1-hehuan1@eswincomputing.com/
>
>   Changes in v4:
>   - Update sdhci-of-dwcmshc.c
>     - Address the compile error from kernel test robot
>       - Remove duplicate implementation of dwcmshc_enable_card_clk()
>       - Add missing dwcmshc_disable_card_clk() function implementation
>   - Link to v3: https://lore.kernel.org/all/20251010093807.1579-1-hehuan1@eswincomputing.com/
>
>   Changes in v3:
>   - Update snps,dwcmshc-sdhci.yaml
>     - Delete clock-output-names, '#clock-cells' and eswin,syscrg-csr
>     - Update description for eswin,hsp-sp-csr
>     - Update drive-impedance-ohm
>     - Update the item of reset-names
>   - Update sdhci-of-dwcmshc.c
>     - Add descriptions for PHY registers
>     - Simplify clock management(remove custom clock provider, use
>       standard clk API)
>     - Replace magic numbers with GENMASK() or FIELD_PREP() macros
>     - Add comments explaining HSP stability assertion writes
>     - Adjust line wrapping to fit within 100-column
>     - Delete forward declarations by moving function definitions
>     - Rename variable is_sdio to is_sd
>     - Replace unclear macros with meaningful alternatives
>   - Link to v2: https://lore.kernel.org/all/20250912093451.125-1-hehuan1@eswincomputing.com/
>
>   Changes in v2:
>   - Delete the previous separate driver and yaml binding file
>   - Update snps,dwcmshc-sdhci.yaml to add support for Eswin EIC7700
>     - Add the new compautible string: "eswin,eic7700-dwcmshc"
>     - Add new properties: clock-output-names, '#clock-cells',
>       drive-impedance-ohm, eswin,hsp-sp-csr and eswin,syscrg-csr
>     - Add customized reset-names for EIC7700 platform
>   - Update sdhci-of-dwcmshc.c to add support for Eswin EIC7700
>     - Add a new struct eic7700_priv to hold Eswin-specific data,
>       including clock phases, register mappings, and drive
>       impedance configuration
>     - Implement EIC7700-specific sdhci_ops
>       - set_clock: support core clock configuration with phase delay
>       - reset: add PHY reset and configuration
>       - set_uhs_signaling: support HS400 DLL lock
>       - platform_execute_tuning: implement delay line tuning and phase
>         code adjustment
>     - Add initialization routine (eic7700_init)
>     - Integrate the new platform data and ops into the driver's match table
>   - Link to v1: https://lore.kernel.org/all/20250516091259.774-1-dongxuyang@eswincomputing.com/
>
> Huan He (2):
>   dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin EIC7700
>   mmc: sdhci-of-dwcmshc: Add support for Eswin EIC7700
>
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  57 +-
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 502 +++++++++++++++++-
>  2 files changed, 542 insertions(+), 17 deletions(-)
>
> --
> 2.25.1
>

The v5 series applied for next, thanks!

Kind regards
Uffe

