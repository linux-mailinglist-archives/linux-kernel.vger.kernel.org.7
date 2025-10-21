Return-Path: <linux-kernel+bounces-862382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C19BF5219
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DE93B8402
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43BC288C2D;
	Tue, 21 Oct 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fqULwlNb"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93AA926
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033729; cv=none; b=cKZBCfJcCCeG0YHkWTUjLlf7BBb1H/d97VgS6Xa5v3sgqzdjaP3o3AKK65ED2FWNvOLnVKF+SjYjDT/lTStnlFbYTcRZuzlExB4NLLihCjw2LAW6e9mF4sLym99Cscuz82CpuCWjUeb6lUd8lNH58Tkfz5erlMGjSdrUt/GgfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033729; c=relaxed/simple;
	bh=hq8OhYoVjgMwCvfTsd84mhxUKz7zh9qPPjoUpGzRkNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF7bDvznuesfC5AlGTOg0nWVcFI+1PZ1I4LHwzdRI+a2lum6DFHyS3wvuZT6jMUjBYL2toPjEYOL4KP6scsUIOTJBW8hfCv0yLLEuqAKlTdyre1eg6uUagnOH2trB+uIbtU4ZTmtlVWSf0Rt7z4veSPCBpflk2ta6d3vDJS7EQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=fqULwlNb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c1006fdcfso10415635a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1761033726; x=1761638526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmJ3kbCZYasBy1tdyPRhi15Hy8S31f6BJlgZcjYUhfI=;
        b=fqULwlNbry44WTcerBjYjOnbQ/pgWwSCc8OmzWbhPcjDJzEPvQz1xFptiFfYp9w2yp
         xwLDL7R/tAly1nb1U/uSGO6FcXvdFdnx75RWxZca+0lPh7sW46k53YteC1NuWCxmxzlx
         pxq18utHDrm64RSOel/jg27K8Ulcx1pPwgx0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033726; x=1761638526;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmJ3kbCZYasBy1tdyPRhi15Hy8S31f6BJlgZcjYUhfI=;
        b=sGLnHHVPuK3bRGKwHoTiOj1Mp8po0/6nbaauuADGq5WH7Us1Dshy72JRH7QXDXUwXY
         D/dxbJKIc2DSxL7sfQZYYC4GBgG6kzCy7dvF1EJJ/7JR4ylanxyPUlrnYYdYW+xqx6nT
         Wm4dJBIPGTqcl9dmt0fDOk1my+4g8rr018YVdRZnLot4aKzKJwFOrHOkk4WFx5T/yTi+
         eauBq5P1xD9C1oIrUBHyvySg80eW4MCSyq/MCccq38DLdwpZrG5XmztNIjMuq+ANBfqE
         EnNRGUZ0BXjt0bbxczQxukyKUOocwLYZDGMgmi7l1Hj/GQMYsWpF8oQ27fnVucWcSvyA
         ksLA==
X-Forwarded-Encrypted: i=1; AJvYcCXQWqOVes8TvVkM8JwPX5dzlXGTPEtZHtBhp/DTb4z6EycXHaXurYZPMGSlkIK4hP2ioo2T6FzV2VNd8a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJxI3sEQ8snz1FBuBu37VOPJ91lJQAMjVc5gQFImpuxWmqNSX
	GuiqOJagPyJM78OeFP+hGGbDqcCg68Pp2v6yyXNHIPOl73pQ1H7Zc3XFbFMeuYBHq98=
X-Gm-Gg: ASbGncvfvoh68+MQPBw3ZssW9UOow07ApdYnHgxS+uGOT8FzBDjmGQxPIND1oi7tXBn
	vyfgRMELbgd1eJ1S40RwQuk+QeBloS7tJlNEsp2LQYusRDdvXUvJ3S1uzBqMNi0ohVwOaOv+BOq
	WIb9jJdjQk5pqfufsBiogsCUPlBvs01dJSYU8V4SzsKG6srtsxyObOvhyO332GtWSSChwcCoIOQ
	dHq+u2asKjQqSXjbdQyBoz0dsL2xq14D8hwx1L9Y+L3gltwcw2IWoy7f8LMRhbfPUtLfoqbDkEF
	ofA0KEz9MHXvCebaIDq4mhIUpOpVRiq5EuzQUy3IRhDj6q4R49XCAX6j4XJ36nUzKGiyYnV4DNp
	443e5+wCXAd6yl7sRahNWiKarTParqtkIXjW66EkjDwyemKNQTBGBbocyJE484jJrJiV8chYQJW
	i061FtHO6baI6xLX3/nqFhAQ==
X-Google-Smtp-Source: AGHT+IEQBbHU46zJp3I8qzuqYSyvo8c+5/g/4Db1HXzfzGIE1r78chLA2+YlpgeKvqwNE6fWnrQZTA==
X-Received: by 2002:a05:6402:1471:b0:62e:e722:a3c7 with SMTP id 4fb4d7f45d1cf-63c1f6345ccmr16006744a12.9.1761033725994;
        Tue, 21 Oct 2025 01:02:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c494301aasm8934112a12.24.2025.10.21.01.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:02:05 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:02:03 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org,
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, l.stach@pengutronix.de,
	shengjiu.wang@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v7 1/7] dt-bindings: display: imx: add HDMI PAI for
 i.MX8MP
Message-ID: <aPc9-wYxGB1KYPyQ@phenom.ffwll.local>
Mail-Followup-To: Shengjiu Wang <shengjiu.wang@nxp.com>,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	lumag@kernel.org, dianders@chromium.org,
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, l.stach@pengutronix.de,
	shengjiu.wang@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org
References: <20250923053001.2678596-1-shengjiu.wang@nxp.com>
 <20250923053001.2678596-2-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923053001.2678596-2-shengjiu.wang@nxp.com>
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

On Tue, Sep 23, 2025 at 01:29:55PM +0800, Shengjiu Wang wrote:
> Add binding for the i.MX8MP HDMI parallel Audio interface block.
> 
> The HDMI TX Parallel Audio Interface (HTX_PAI) is a digital module that
> acts as the bridge between the Audio Subsystem to the HDMI TX Controller.
> This IP block is found in the HDMI subsystem of the i.MX8MP SoC.
> 
> Aud2htx module in Audio Subsystem, HDMI PAI module and HDMI TX
> Controller compose the HDMI audio pipeline.
> 
> In fsl,imx8mp-hdmi-tx.yaml, add port@2 that is linked to pai_to_hdmi_tx.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

dt patches need an ack from dt maintainers before you push them, please
make sure you follow that for the next changes.
-Sima

> ---
>  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    | 12 ++++
>  .../display/imx/fsl,imx8mp-hdmi-pai.yaml      | 69 +++++++++++++++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pai.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> index 05442d437755..6211ab8bbb0e 100644
> --- a/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> @@ -49,6 +49,10 @@ properties:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: HDMI output port
>  
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Parallel audio input port
> +
>      required:
>        - port@0
>        - port@1
> @@ -98,5 +102,13 @@ examples:
>                      remote-endpoint = <&hdmi0_con>;
>                  };
>              };
> +
> +            port@2 {
> +                reg = <2>;
> +
> +                endpoint {
> +                    remote-endpoint = <&pai_to_hdmi_tx>;
> +                };
> +            };
>          };
>      };
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pai.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pai.yaml
> new file mode 100644
> index 000000000000..4f99682a308d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pai.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/fsl,imx8mp-hdmi-pai.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8MP HDMI Parallel Audio Interface
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +description:
> +  The HDMI TX Parallel Audio Interface (HTX_PAI) is a bridge between the
> +  Audio Subsystem to the HDMI TX Controller.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8mp-hdmi-pai
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: apb
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description: Output to the HDMI TX controller.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mp-clock.h>
> +    #include <dt-bindings/power/imx8mp-power.h>
> +
> +    audio-bridge@32fc4800 {
> +        compatible = "fsl,imx8mp-hdmi-pai";
> +        reg = <0x32fc4800 0x800>;
> +        interrupt-parent = <&irqsteer_hdmi>;
> +        interrupts = <14>;
> +        clocks = <&clk IMX8MP_CLK_HDMI_APB>;
> +        clock-names = "apb";
> +        power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PAI>;
> +
> +        port {
> +            pai_to_hdmi_tx: endpoint {
> +                remote-endpoint = <&hdmi_tx_from_pai>;
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch

