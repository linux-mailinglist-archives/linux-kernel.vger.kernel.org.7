Return-Path: <linux-kernel+bounces-743669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09AFB10197
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3ABAC1093
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EF323185E;
	Thu, 24 Jul 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRntSL8t"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E291422D4DC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341821; cv=none; b=WfHoKTP7iW8poLnheupmie1KRm+PFdrQwZ7O0vtNeSjDK8Kled/JE9fk7938jxONgQJiDf/NDdw2pckShyJNOCmHjbp5IFlFANC563D95hIE5NU0Y4cN0zp9mGvSmW+4cBTXX8bSH3UyXO8YaF7ue8CZhg+0+790YDJCfolITHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341821; c=relaxed/simple;
	bh=6nGhBLrN5DA7nUAfm4ui0pjF3M8jgR8PyNJ6paQnnZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZjNBaPwFqIQdzACwQgO6s9L7p+tGDtUuPoo+2oOcipGqqS7Da9sQ4eIkP+ym+WJBvjI/AAZZWCDH6+fY//DdmyT4hajZQUD1j/fmFL4ar2D7ZashzE/qdGXUOubShsfqA5I+qNM5RwtbNPQRF9+wt4UB9YYM3zmOnrwaPWL0xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TRntSL8t; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so1474116a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753341818; x=1753946618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IyRqFhbkdETB9+gjPBBcsm9FuFvhp1ffUr7fYiNkiU=;
        b=TRntSL8taFtiDd3IvSfUoMnliRqvXjYTQCRY8CoZ64WS+vxP3hiov0KBwWvZz4rn1T
         ZVCpNpjeq96SJlDpruHyqbhQ4Z/XkETrLMDfEoI8Hycv2PKUD/kwZjA6ql8MZdcNrW9l
         rhzYQiaobcqEKFIqPpEi3ybVddWnmWR+2uLN7tBmv5sIAjgTxbBpD32T+Ev/ybTaws+Z
         DmCriHfgyyd0ckvaLa2URN+ky7PkVIcB2i43fq05NeqmO34vVBoxVnFzlrGJgeB8Z9xQ
         uYKWYTBCVYsp09/1Mag+qMB5gkdClg2kdNOZlJVy5+8iyB5fufm6+66bl7g+4TeaoIBF
         WyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753341818; x=1753946618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IyRqFhbkdETB9+gjPBBcsm9FuFvhp1ffUr7fYiNkiU=;
        b=wsZmirizM8udTElWWjy5qzsRzOBxjAJ/+yPrqm89HEu/CszsfTyQpoJnEtwNEGaI8H
         vFqzQwVV8Y0IDKIV0xM3dzxeVk/SUXJeY2q5rK77s4vA8kXXaqHgjYj31GlfcK5Rjsh7
         bZA8lpFFaFAZZFPjG0YOjIXMqeUNdLHHQ/K5+VuQ1pp9t/GGnsYwA8WH5HEDCNVIQtkS
         62UbEFY/cPfSwNrXS5ho0DL3/GmiOgGSK+C0wzC1GRIaNy3r1nmpqr7rxEq+y5jLeE/r
         x+RfwIniwLETm4OUq1sA09txiXUhJvjAUlTMHIawS1sbkzDMAESp65/e20jNP2S5kZfo
         +7PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPcgNkGQsLqHTtmLKvcj1j16FVhAD8OTPMzLzvNPLSybp98pfWAo9Sypp8+phnOWCzkuDGWU6RYUgbipg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7BBENzgk0E7kiwjPmYtCoKN8t65+BsV9aB3f/wIONo+8ptAR
	cjy12gRuHytMA4m4GzGIWKzNIbZHYRgbrMhG/g8jrpgegjAQt7e0rW7DwHUG0+ZwHzk=
X-Gm-Gg: ASbGnctXWfqPbriBhhN3AE7AbuYAWfl8oRfESbYcmnVfWwKhIEdt9i9R8wU/DqRzEaO
	iu9UULqZTuzmuVjzmcVlWWfVKK1JkJQHanIhrHr1RKQhSy5MPtmz0n3X0usp7N2kBjwc3zCx41D
	9jp6Bux1V7b4mLOqTcccp7GnwIgMhVie3tngO9dUL7sFAzUKPGL32uZfmXuRg1JDUH46OvmgORk
	kpJs/n93p6MhLLmmisVmeHTzJONGoKKkowAU9vPUWDbwotaa0U/lbVOt1FkBZTZWBfQ6iGtaqIf
	vi9cKJx8l5LkPmk3BOVdHH2w+YE2ZQLEI8g1NFc4uQ0SmextMlWVOjAG6Widd+mwgaIdHZjsAbR
	PPSieHGxBdgVijC6vCWzUDmeaGqKSVldImU8waCML62gu
X-Google-Smtp-Source: AGHT+IGoRj4xEQVnuuhDhkJ4U07sNs7To6AmXU1yyMNvclDRha0FEWE1smSmNDjqs2kffoiWB7fDbA==
X-Received: by 2002:a17:906:794b:b0:ae6:abe9:4daa with SMTP id a640c23a62f3a-af2f717a556mr684315766b.27.1753341818029;
        Thu, 24 Jul 2025 00:23:38 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:706f:1fb4:134c:465d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c496e28sm71571766b.1.2025.07.24.00.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:23:37 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:23:32 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: srinivas.kandagatla@oss.qualcomm.com
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/23] arm64: dts: qcom: x1e80100: move dsp audio nodes
 to dedicated dts
Message-ID: <aIHfPZaRmTjI7w8D@linaro.org>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-2-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723222737.35561-2-srinivas.kandagatla@oss.qualcomm.com>

On Wed, Jul 23, 2025 at 11:27:15PM +0100,
srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> All the device tree nodes for audioreach dsp are duplicated across all
> the SoC dtsi files, Move this to a dedicated dtsi file so to remove some
> duplication, make it consistent across all device trees and also make it
> easy for new SoC's to add audio support.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  .../arm64/boot/dts/qcom/audioreach-audio.dtsi | 45 +++++++++++++++++++
>  .../boot/dts/qcom/x1-asus-zenbook-a14.dtsi    |  1 +
>  arch/arm64/boot/dts/qcom/x1-crd.dtsi          |  1 +
>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts  |  1 +
>  .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   |  1 +
>  .../dts/qcom/x1e80100-asus-vivobook-s15.dts   |  1 +
>  arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi  |  6 +++
>  .../dts/qcom/x1e80100-dell-xps13-9345.dts     |  1 +
>  .../dts/qcom/x1e80100-hp-omnibook-x14.dts     |  1 +
>  .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  1 +
>  .../dts/qcom/x1e80100-microsoft-romulus.dtsi  |  1 +
>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts     |  1 +
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 43 ++----------------
>  13 files changed, 64 insertions(+), 40 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/audioreach-audio.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi
> 
> [...]
> diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> index c771fd1d8029..1d8a75fba301 100644
> --- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
> +#include "x1e80100-audio.dtsi"
>  #include "x1e80100-pmics.dtsi"
>  
>  / {
> diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> index c9f0d5052670..19b993fdd17f 100644
> --- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
> +#include "x1e80100-audio.dtsi"
>  #include "x1e80100-pmics.dtsi"
>  
>  / {
> diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> index 2d9627e6c798..6df3ee553bc7 100644
> --- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> @@ -10,6 +10,7 @@
>  
>  #include "x1e80100.dtsi"
>  #include "x1e80100-pmics.dtsi"
> +#include "x1e80100-audio.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. X1E001DE Snapdragon Devkit for Windows";
> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> index ac1dddf27da3..cf2cf3e520fa 100644
> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  #include "x1e80100.dtsi"
> +#include "x1e80100-audio.dtsi"
>  #include "x1e80100-pmics.dtsi"
>  
>  / {
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
> index 71b2cc6c392f..82b08350da17 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
> @@ -13,6 +13,7 @@
>  
>  #include "x1e80100.dtsi"
>  #include "x1e80100-pmics.dtsi"
> +#include "x1e80100-audio.dtsi"
>  
>  / {
>  	model = "ASUS Vivobook S 15";
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi
> new file mode 100644
> index 000000000000..e03441bb2a79
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi
> @@ -0,0 +1,6 @@
> +#include "audioreach-audio.dtsi"
> +
> +&q6apmdai{
> +	iommus = <&apps_smmu 0x1001 0x80>,
> +		 <&apps_smmu 0x1061 0x0>;
> +};

I think you should inline this into x1e80100.dtsi and drop the extra
#include from all the device DTs. x1e80100.dtsi already references
audioreach nodes, so it's not possible to build without including
x1e80100-audio.dtsi anyway:

../arch/arm64/boot/dts/qcom/x1e80100.dtsi:4098.34-4114.5: ERROR (phandle_references): /soc@0/codec@6aa0000: Reference to non-existent node or label "q6prmcc"
../arch/arm64/boot/dts/qcom/x1e80100.dtsi:4320.31-4436.5: ERROR (phandle_references): /soc@0/pinctrl@6e80000: Reference to non-existent node or label "q6prmcc"

Thanks,
Stephan

