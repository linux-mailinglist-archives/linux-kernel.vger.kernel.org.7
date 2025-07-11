Return-Path: <linux-kernel+bounces-727699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBDFB01E49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B394A1CA7762
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8475C2DCF5D;
	Fri, 11 Jul 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0vKWX0Q"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F92D780D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241841; cv=none; b=m9Shi/14otH6vlfNnFb81CFrew/+65zVRPDPOSC1kgQVQhAd5n3r5gSbdUrrKsX1voV80/u9xAEuYfkKKp9Ewa1W6fAuPlY/BSHnduiwOtS/r5cW09gHQk8OMApK/Y4XXYZ3ZfjQ6E80U9mi/ROQV3croXBeO5r4EcvfrIg6FIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241841; c=relaxed/simple;
	bh=xrOfrea3ktIO3rH/cRZjG/WzXdNS8Fe/7C22LVDHtd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0MbLBHEsOxzDJkzkIsMQc7s9RjQoaUprwLHs1HCnM9GXRe7c7xkFuaG480VGgEEchuasu6MJbaRRVDJ1SR9kMAGdmDYxv1J/+8+RQUjvrA0GsFq4fR/En0J5CxoYksrJnumB6wjV1eEaP+OqRz12i+EhvFvKYMA72C2Q+dir5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W0vKWX0Q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e81d37a7so1351783b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752241839; x=1752846639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mxCChrglHn+Uqy0YUudJl4m6M4rjCL8xQf7aFXlmf3g=;
        b=W0vKWX0QDjMc7M4E53btXqi/fZKT2AHHqAsDH6LDM9lbB8fLYgy8j2G6+5U/AGT94V
         Sk6W6Vcwz+Akc4BP4VHttEyrl6+yPHtQcpriU5nTXRZ7ZbefLorI46b4WDHdeHfJhzEw
         R/VQi+fW772BQpPzEh3MCc7ccYGQmV1/Iy65lDxQW5kLZo1EHrt5ArUKnHf6R8ogoltc
         eHZre9nr6FTEhOaOwftpkA/3b0EAQoGW3c+WSDdUeBacPFt42GXD7j7Ka4EXQaCASk8M
         lK/vgype0Da1q4BMLMlV+fLD/sOM1yYcYKrfX2WbkePnngQBQTDZm5yZQ9/ddgI3P3eY
         qbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241839; x=1752846639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxCChrglHn+Uqy0YUudJl4m6M4rjCL8xQf7aFXlmf3g=;
        b=J8PL9D8kwv8LptwgnSRF5+GT6ZwaZos1V6BqSTDyrCiLp3IawR+JK3l/rDKLL01sEa
         bCa9bqKZhTlTq9viH+ItThdhUGIwP/xZdZS8n8mRTU06hVq+efUZ0WomyaQPfI6dfHHD
         JnjDc2jZtKn1HqCUKUHimnw10DXggDp8oBEjmx5WqH9aAt2Eglzq48dkjFUrP77NHh2l
         kAAcNKUEly9imYgxdxM7bxqLXsSAPstUNSU/vjcF2BblTVqHFM46W3Trd8la3yNJA0DE
         btg7X4Fb3s12hSfMWkcMehfmiM6K1ADOnYFyVl0F0kyrRfoWLeYmAcu59FV5zPDF8m+C
         zuOA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ffDNo1MEzf+2/Yx1wk/fo2kfbtmvWM1c0zXvclXBBUe1ue/FB6yGcGffWHF/ekCBrAiXCGxC4+hKoPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVYOU0y01zY3+oJeF8mfqrJKEDJ39vy1Ma3tco0aiZOhWff40
	VGYzei9sXwZDJ77FpgqEsFylb5YT0PiHYIaFsBmVNwEe06gKI4HI2LCJZy/k/gO0+qFBplq9Crl
	gM08JqxHEzKKyuW0T+bA5YCOZV0s4x2L8cK0MGX25PQ==
X-Gm-Gg: ASbGnctQZoBFuv24swPS/M1i9bu7nAdH3Ghk9tW/bEyzgH4mKd7A3q9xL/E0MOc4FdG
	0O3cYTYjqp6rtj32sLYk/IJP8/yRfjlRyx+QWNOMaqv8DwjHBZto3ayvIihbR+SzVdb3/+r5/YM
	WD9/ETNiqCK5ErAmaG+7yqBf3Gw2wMeUK6iEv3U5c8+zUn+1+sqCszFI4N1lcZIfvcZfa2cxbxR
	Cy9BNzBRVJMwdFJmSnzLfj5NoN6+gWg+kpGNqsE
X-Google-Smtp-Source: AGHT+IF9w1zlsOy9Tpc/VqUpX5hlsohRMIl3W8B9IgIpmh4707Cf+Roh6PhUrMsx1N8++dq63Ov8Ydg2FFN95JGpX3E=
X-Received: by 2002:a05:6a00:856:b0:748:fcfa:8bd5 with SMTP id
 d2e1a72fcca58-74ee0bb022amr4951233b3a.3.1752241839246; Fri, 11 Jul 2025
 06:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-trace-noc-v10-0-a83b5c63da34@quicinc.com> <20250611-trace-noc-v10-1-a83b5c63da34@quicinc.com>
In-Reply-To: <20250611-trace-noc-v10-1-a83b5c63da34@quicinc.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 11 Jul 2025 14:50:27 +0100
X-Gm-Features: Ac12FXz5suXDSfb0reqEF8K7TSk9o2sFELW1ViZ5ykT-xvY6SdObq4JpNg1MVng
Message-ID: <CAJ9a7Vhs=5pXu4JvqeAbLBbV97x4xwVP6ag4oiK5sbJntwNNqA@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: arm: Add device Trace Network On
 Chip definition
To: Yuanfang Zhang <quic_yuanfang@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kernel@oss.qualcomm.com, 
	linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Jun 2025 at 11:43, Yuanfang Zhang <quic_yuanfang@quicinc.com> wrote:
>
> Add a new coresight-tnoc.yaml file to describe the bindings required to
> define Trace Network On Chip (TNOC) in device trees. TNOC is an
> integration hierarchy which is a hardware component that integrates the
> functionalities of TPDA and funnels. It collects trace form subsystems
> and transfers to coresight sink.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-tnoc.yaml          | 113 +++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tnoc.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tnoc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..9d1c93a9ade3ff14ede4a8d1481782776cf47be9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tnoc.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/qcom,coresight-tnoc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Trace Network On Chip - TNOC
> +
> +maintainers:
> +  - Yuanfang Zhang <quic_yuanfang@quicinc.com>
> +
> +description: >
> +  The Trace Network On Chip (TNOC) is an integration hierarchy hardware
> +  component that integrates the functionalities of TPDA and funnels.
> +
> +  It sits in the different subsystem of SOC and aggregates the trace and
> +  transports it to Aggregation TNOC or to coresight trace sink eventually.
> +  TNOC embeds bridges for all the interfaces APB, ATB, TPDA and NTS (Narrow
> +  Time Stamp).
> +
> +  TNOC can take inputs from different trace sources i.e. ATB, TPDM.
> +
> +  Note this binding is specifically intended for Aggregator TNOC instances.
> +
> +# Need a custom select here or 'arm,primecell' will match on lots of nodes
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - qcom,coresight-tnoc
> +  required:
> +    - compatible
> +
> +properties:
> +  $nodename:
> +    pattern: "^tn(@[0-9a-f]+)$"
> +
> +  compatible:
> +    items:
> +      - const: qcom,coresight-tnoc
> +      - const: arm,primecell
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: apb_pclk
> +
> +  clocks:
> +    items:
> +      - description: APB register access clock
> +
> +  in-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    patternProperties:
> +      '^port(@[0-9a-f]{1,2})?$':
> +        description: Input connections from CoreSight Trace Bus
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +  out-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    additionalProperties: false
> +
> +    properties:
> +      port:
> +        description:
> +          Output connection to CoreSight Trace Bus
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - in-ports
> +  - out-ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    tn@109ab000  {
> +      compatible = "qcom,coresight-tnoc", "arm,primecell";
> +      reg = <0x109ab000 0x4200>;
> +
> +      clocks = <&aoss_qmp>;
> +      clock-names = "apb_pclk";
> +
> +      in-ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {
> +          reg = <0>;
> +
> +          tn_ag_in_tpdm_gcc: endpoint {
> +            remote-endpoint = <&tpdm_gcc_out_tn_ag>;
> +          };
> +        };
> +      };
> +
> +      out-ports {
> +        port {
> +          tn_ag_out_funnel_in1: endpoint {
> +            remote-endpoint = <&funnel_in1_in_tn_ag>;
> +          };
> +        };
> +      };
> +    };
> +...
>
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

