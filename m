Return-Path: <linux-kernel+bounces-846939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BFCBC97AC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C399421369
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245B2EA48B;
	Thu,  9 Oct 2025 14:20:46 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFF92EA482;
	Thu,  9 Oct 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019646; cv=none; b=mDbUrk0feeWd4vkOoz59QLWV29EnbVH5hDgWgx8nNOoPU4/3uJDMV6XA92pmYT0zmB3hBxgTVByCjxLLbRNlrxgojekmOuZityt7NRT/A3KLMbSPhENXyvGCzn6wVhQyjsgWhs2+k5TZUyV8KNYpCRkKOe2/S9yuO3avI0O2kNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019646; c=relaxed/simple;
	bh=ksqIhHvbA8rzmBvcnmVE74QHlRZLz9tLDP/gwWwP1qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGmKT4WYbUDi08rwL0M4QPm7SXCnZlmq8O7699Hl1Jsj8Eb4HXn2OmbYAqldR28T+GVnBgjNUlcyyo4N3/eBaoMuR9dkhyd+RN96RA7U/LEEIR5eqKHX9VAE242IOSrM6TH2bKoVmu0WKz5Biz6+o8vDsYKf4Ppbj2gK853XeP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cjBQk37hsz9sSm;
	Thu,  9 Oct 2025 16:02:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z14JQMJxERpX; Thu,  9 Oct 2025 16:02:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cjBQk23D0z9sSb;
	Thu,  9 Oct 2025 16:02:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 31FB08B76C;
	Thu,  9 Oct 2025 16:02:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id RkFPso1hSIXA; Thu,  9 Oct 2025 16:02:38 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 738278B767;
	Thu,  9 Oct 2025 16:02:37 +0200 (CEST)
Message-ID: <7a818442-2c5b-433d-874f-4a11ce3ed42f@csgroup.eu>
Date: Thu, 9 Oct 2025 16:02:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: powerpc: Add Freescale/NXP MPC83xx SoCs
To: j.ne@posteo.net, Scott Wood <oss@buserror.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250412-ppcyaml-soc-v4-1-bd34f4613d31@posteo.net>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250412-ppcyaml-soc-v4-1-bd34f4613d31@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/04/2025 à 15:55, J. Neuschäfer via B4 Relay a écrit :
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> Add a new binding for MPC83xx platforms, describing the board compatible
> strings used in currently existing device trees.
> 
> Note that the SoC bus is called immr@... in many existing devicetrees,
> but this contradicts the simple-bus binding.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---

Looks consistant with mpc83xx platforms.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

For correctness with dt-bindings documentation format check with DT 
maintainers/reviewers.

> Changes in v4:
> - Rebase on v6.15-rc1
> - Link to v3: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20250220-ppcyaml-soc-v3-1-b8c98a61bc1a%40posteo.net&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C6a17702bd4a14e74161208dd79cbabc9%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638800637855467799%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=bmGcvUV0O7kyAlbwQQw1Ct8a%2FFz7ZI1Ama79vSykKjo%3D&reserved=0
> ---
> 
> V4:
> - Try to list all existing compatible strings for MPC83xx boards
> 
> V3:
> - split out as a single patch
> - otherwise no changes
> 
> V2:
> - part of series [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
>    Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20250207-ppcyaml-v2-1-8137b0c42526%40posteo.net%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C6a17702bd4a14e74161208dd79cbabc9%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638800637855486884%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=JcWFEfu6kvOEwZPXGlH1wG3Ab2zyukRXva%2FW2sr05lA%3D&reserved=0
> - trim subject line
> - fix property order to comply with dts coding style
> - add Rob Herrings's R-b tag
> ---
>   .../bindings/powerpc/fsl/fsl,mpc83xx.yaml          | 93 ++++++++++++++++++++++
>   1 file changed, 93 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fsl,mpc83xx.yaml b/Documentation/devicetree/bindings/powerpc/fsl/fsl,mpc83xx.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..9e37d155c5829a652d1e4e59536b6586a58d530e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/fsl,mpc83xx.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fpowerpc%2Ffsl%2Ffsl%2Cmpc83xx.yaml%23&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C6a17702bd4a14e74161208dd79cbabc9%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638800637855503120%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=5X55e7ezKH%2ByZkaMchZ3iEIIKt1cLZBcDIsUqyMiBA0%3D&reserved=0
> +$schema: https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C6a17702bd4a14e74161208dd79cbabc9%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638800637855517944%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=9%2BNfMJcauF%2FFaVQpIovnwAKbRkclTrmZRPehLopstsM%3D&reserved=0
> +
> +title: Freescale PowerQUICC II Pro (MPC83xx) platforms
> +
> +maintainers:
> +  - J. Neuschäfer <j.ne@posteo.net>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: MPC83xx Reference Design Boards
> +        items:
> +          - enum:
> +              - fsl,mpc8308rdb
> +              - fsl,mpc8315erdb
> +              - fsl,mpc8360rdk
> +              - fsl,mpc8377rdb
> +              - fsl,mpc8377wlan
> +              - fsl,mpc8378rdb
> +              - fsl,mpc8379rdb
> +
> +      - description: MPC8313E Reference Design Board
> +        items:
> +          - const: MPC8313ERDB
> +          - const: MPC831xRDB
> +          - const: MPC83xxRDB
> +
> +      - description: MPC8323E Reference Design Board
> +        items:
> +          - const: MPC8323ERDB
> +          - const: MPC832xRDB
> +          - const: MPC83xxRDB
> +
> +      - description: MPC8349E-mITX(-GP) Reference Design Platform
> +        items:
> +          - enum:
> +              - MPC8349EMITX
> +              - MPC8349EMITXGP
> +          - const: MPC834xMITX
> +          - const: MPC83xxMITX
> +
> +      - description: Keymile KMETER1 board
> +        const: keymile,KMETER1
> +
> +      - description: MPC8308 P1M board
> +        const: denx,mpc8308_p1m
> +
> +patternProperties:
> +  "^soc@.*$":
> +    type: object
> +    properties:
> +      compatible:
> +        oneOf:
> +          - items:
> +              - enum:
> +                  - fsl,mpc8315-immr
> +                  - fsl,mpc8308-immr
> +              - const: simple-bus
> +          - items:
> +              - const: fsl,mpc8360-immr
> +              - const: fsl,immr
> +              - const: fsl,soc
> +              - const: simple-bus
> +          - const: simple-bus
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    / {
> +        compatible = "fsl,mpc8315erdb";
> +        model = "MPC8315E-RDB";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        soc@e0000000 {
> +            compatible = "fsl,mpc8315-immr", "simple-bus";
> +            reg = <0xe0000000 0x00000200>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            device_type = "soc";
> +            ranges = <0 0xe0000000 0x00100000>;
> +            bus-frequency = <0>;
> +        };
> +    };
> +
> +...
> 
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250220-ppcyaml-soc-cae1f14cf389
> 
> Best regards,


