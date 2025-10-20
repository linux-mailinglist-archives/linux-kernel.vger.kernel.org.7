Return-Path: <linux-kernel+bounces-860483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400ACBF03BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F633BE58D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225151F4CBF;
	Mon, 20 Oct 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="onWXANZn"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142C2F60CA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953109; cv=none; b=tzLxU4YRBCxFOVxbW/bHeTcm/+U2CvlCV/aYmEANJOl8ZItTPrum5NA5NCUCgp15GitIRxR4g9wFa7DGgeDcwBv8juIG99kCCARFPRCBtodhR0143i4ygS1aas9G0Uw1BrAGVExV9xt5xbIoCTMJ40yuRTFFv+ZHDSAuuflK6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953109; c=relaxed/simple;
	bh=ZM99vAaDenOAHQs62WH/1ACKRvDOf/c1+nx6vwi0iiU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l3SOKmb5RXqQsRL8GupdrNuEY7P24asUfTdWmJ+CBv7qRGI433OdsN/SRfaxxPf26Mw4+csyZyhW+/dJrBant8Iax3M9WhBl0V82RzJvWJZZ2vx49gVr3PuHW951aRwxeYjIje7TH0hr1HbuhqbWac2rnc0rkfdlJRw1uYns4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=onWXANZn; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1760953090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5GKFSb8/CEfXGsPeMSq9twJk4tF7yOdz4CDd5l/dKU=;
	b=onWXANZnK+qqfixEuAceXS1lWRx+JeiaxMXIWo0ENGg8AfYu6LSCzWRujpeE3aJgRl1MKD
	5UYyN5Yu3LXWx0Pfe51SQNTWPgNGGwPlQub+f+qcMrlq1Ku3R9tK2sRXTOVmF5Y7wrAam9
	paPdawkWZi6FjgBdOrwdkMzsQGQdYngyKTiWWVdnTCPE3hdsVUg/YvhuwmP+ZP3RQ+kq6r
	a1dg7XBXJsQ+fAYnAyg3JrzuJLlaY24b5vin667/995YhHWgvY9Agftc09sFMPjGhnxV6M
	lEJLdbXKhmGgw7RyRLeRm+zJ5nHdrkUyOLVr8zM7RnWrXoWozQe3ocHOXkRZDg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 11:38:02 +0200
Message-Id: <DDN1RQB4LG0X.30F0A3IMJ4YI4@cknow-tech.com>
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-clk@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <huangtao@rock-chips.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: clock: Add support for rockchip
 pvtpll
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Elaine Zhang" <zhangqing@rock-chips.com>, <mturquette@baylibre.com>,
 <sboyd@kernel.org>, <sugar.zhang@rock-chips.com>, <heiko@sntech.de>,
 <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>
References: <20251020023724.2723372-1-zhangqing@rock-chips.com>
 <20251020023724.2723372-5-zhangqing@rock-chips.com>
In-Reply-To: <20251020023724.2723372-5-zhangqing@rock-chips.com>
X-Migadu-Flow: FLOW_OUT

On Mon Oct 20, 2025 at 4:37 AM CEST, Elaine Zhang wrote:
> Add pvtpll documentation for rockchip.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,clk-pvtpll.yaml   | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,clk-=
pvtpll.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.=
yaml b/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
> new file mode 100644

Should this file have the 'clk-' part in its name?
In a way this is different from the other DT binding files, but none of
the others have the 'clk-' part in their file name:

me@pc:~/linux/Documentation/devicetree/bindings/clock$ ls -lh rockchip,*
-rw-rw-r-- 1 me me 2,9K okt 20 11:32 rockchip,px30-cru.yaml
-rw-rw-r-- 1 me me 1,9K okt 20 11:32 rockchip,rk3036-cru.yaml
-rw-rw-r-- 1 me me 1,8K okt 20 11:32 rockchip,rk3128-cru.yaml
-rw-rw-r-- 1 me me 2,3K okt 20 11:32 rockchip,rk3188-cru.yaml
-rw-rw-r-- 1 me me 2,1K okt 20 11:32 rockchip,rk3228-cru.yaml
-rw-rw-r-- 1 me me 2,6K okt 20 11:32 rockchip,rk3288-cru.yaml
-rw-rw-r-- 1 me me 2,2K okt 20 11:32 rockchip,rk3308-cru.yaml
-rw-rw-r-- 1 me me 2,1K okt 20 11:32 rockchip,rk3328-cru.yaml
-rw-rw-r-- 1 me me 2,4K okt 20 11:32 rockchip,rk3368-cru.yaml
-rw-rw-r-- 1 me me 2,5K okt 20 11:32 rockchip,rk3399-cru.yaml
-rw-rw-r-- 1 me me 1,5K okt 20 11:32 rockchip,rk3528-cru.yaml
-rw-rw-r-- 1 me me 1,1K okt 20 11:32 rockchip,rk3562-cru.yaml
-rw-rw-r-- 1 me me 1,8K okt 20 11:32 rockchip,rk3568-cru.yaml
-rw-rw-r-- 1 me me 1,2K okt 20 11:32 rockchip,rk3576-cru.yaml
-rw-rw-r-- 1 me me 1,6K okt 20 11:32 rockchip,rk3588-cru.yaml
-rw-rw-r-- 1 me me 2,2K okt 20 11:32 rockchip,rv1108-cru.yaml
-rw-rw-r-- 1 me me 1,3K okt 20 11:32 rockchip,rv1126-cru.yaml

> index 000000000000..8be34bcde7b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,clk-pvtpll.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Pvtpll
> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - rockchip,rv1103b-core-pvtpll
> +          - rockchip,rv1103b-enc-pvtpll
> +          - rockchip,rv1103b-isp-pvtpll
> +          - rockchip,rv1103b-npu-pvtpll
> +          - rockchip,rv1126b-core-pvtpll
> +          - rockchip,rv1126b-isp-pvtpll
> +          - rockchip,rv1126b-enc-pvtpll
> +          - rockchip,rv1126b-aisp-pvtpll
> +          - rockchip,rv1126b-npu-pvtpll
> +          - rockchip,rk3506-core-pvtpll
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  rockchip,cru:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the main Clock and Reset Unit (CRU) controller.
> +      Required for PVTPLLs that need to interact with the main CRU
> +      for clock management operations.
> +
> +required:
> +  - "#clock-cells"
> +  - compatible
> +  - reg
> +  - clock-output-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pvtpll_core: pvtpll-core@20480000 {
> +      compatible =3D "rockchip,rv1126b-core-pvtpll", "syscon";
> +      reg =3D <0x20480000 0x100>;
> +      #clock-cells =3D <0>;
> +      clock-output-names =3D "clk_core_pvtpll";
> +    };
> +
> +  - |
> +    pvtpll_isp: pvtpll-isp@21c60000 {
> +      compatible =3D "rockchip,rv1126b-isp-pvtpll", "syscon";
> +      reg =3D <0x21c60000 0x100>;
> +      rockchip,cru =3D <&cru>;
> +      #clock-cells =3D <0>;
> +      clock-output-names =3D "clk_isp_pvtpll";
> +    };
> +
> +  - |
> +    pvtpll_enc: pvtpll-enc@21f00000 {
> +      compatible =3D "rockchip,rv1126b-enc-pvtpll", "syscon";
> +      reg =3D <0x21f00000 0x100>;
> +      #clock-cells =3D <0>;
> +      clock-output-names =3D "clk_vepu_pvtpll";
> +    };
> +
> +  - |
> +    pvtpll_aisp: pvtpll-aisp@21fc0000 {
> +      compatible =3D "rockchip,rv1126b-aisp-pvtpll", "syscon";
> +      reg =3D <0x21fc0000 0x100>;
> +      rockchip,cru =3D <&cru>;
> +      #clock-cells =3D <0>;
> +      clock-output-names =3D "clk_vcp_pvtpll";
> +    };
> +
> +  - |
> +    pvtpll_npu: pvtpll-npu@22080000 {
> +      compatible =3D "rockchip,rv1126b-npu-pvtpll", "syscon";
> +      reg =3D <0x22080000 0x100>;
> +      rockchip,cru =3D <&cru>;
> +      #clock-cells =3D <0>;
> +      clock-output-names =3D "clk_npu_pvtpll";

rockchip,cru line as the last line?

Cheers,
  Diederik

> +    };
> +
> +...


