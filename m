Return-Path: <linux-kernel+bounces-853884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13B3BDCCF7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B6B192859E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2153F30FF28;
	Wed, 15 Oct 2025 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sJKXWdA8"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140D3126C4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511518; cv=none; b=Gg8MeW+rXYrXfX0tVIUG6rYct2P8Qgvb4PLAYbdxC7B50V08G8m1Wv+98n91wfbDv46sjrljDXWRePX0glyzNABFhn79pvJ/PBLF2RIhToE3rVB5v7PMZfQBB4Z0j/7Mo2jnIYLIpe21bS1NK5FWN+YfKqsC10IO6K1GJ+gjxXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511518; c=relaxed/simple;
	bh=+Jv5HGJSVBgQqOwu2En1DyoXH708B/JmeMuHSxfKmh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkotjUkQm6KGWAG02qX6svmNOZS5gN6ctwZRa6rgyj6VnpTtnPq97KJr6nguzyi8RYIVBhrAOpP5WobnmkXheafPNswEtVWQHqS7zgy13+bXyvJNXZQrv6CXXvABuGviUjTPmPoj3vI8iZvicOZoofHMdcGjy5NkIbSwBgKWCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sJKXWdA8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so4448713f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760511515; x=1761116315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GgRnhCs3Gb02J6lHdQZQG9KVskN5VfKfIDHxr0XwQeA=;
        b=sJKXWdA83oHjbort4/YxOtK8eHo/wfCjnzgtbe2GOFURilmzsfGQvZisWTH8a6BCZw
         fHVFkxwoS+6OfjTTl+U5JvHUGocxdvV/gGG3MpoMtC/x0y8sIOQFDXHIOPfMc+Jbx0GZ
         y3tBCA1uxWn5Yhi1XDsQZx9ETbbZaB8oXdbMqC+pn1L7qD2GF2SYCavKdedOOIKg6Nmm
         ASlKiTcwvxBZ/cb+2jS1ufwnbMiBOeLnt6B6IpRqui39unnGrXjS0UZXKg185Y7S2JbO
         n0pefa253hIhwS7XQ+DMVkjXd3OVjZB84ykz9CpHSKD9zOJo3k1LUG5uKAjQ2kvynf/Q
         wjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760511515; x=1761116315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgRnhCs3Gb02J6lHdQZQG9KVskN5VfKfIDHxr0XwQeA=;
        b=S7/6tKWpSXa+JfL1V3Dct9qwjsPpqihnJ+RQ/NOU7pOM+ni2o8DRy+BHhPGAzycb4e
         z2/h8Qrk5dCNtrC+XF5mKlG6Kpni/jxXufcZAjn0WP3EyZT3kB03Morx/nyO7pErDIPL
         UGam+Gs2TUxk47+crENNU2qmYhL2eBPYm4oijr8MOpJ+Fm/GLqTDanwtVcAOAe8+S23t
         /fjmRvSnrS8ieiBMxVCMbrKydnaj8RGsxQK01bwc2DqJisGoaeiFL/1Xm0tsRAx8X0Vi
         jXZ9cks0yXyhrus32BSnVRCunVlQBq9rdumP7VdatVDNFn8JcODx9O2IMZkY+9jznnoM
         RA3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXM4ZlkyKfDYUE4urmujS9K2nyct04ZuKgsFW/3kboDSbixqLxriQdieUeuRQvw3Urogf/eEJrAnyJ9xwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhqO85fMXGHXA+xlGwv77uyXetet1J3jymXpjGm+VADRUMhVg
	K8ZlMHU9j1j0OiIHS3JvaOWbcRcCBfiSyJL8z9vTPvfeQ1LhNS50H5EN+Gf+qjbqz6k=
X-Gm-Gg: ASbGncuQNUgFsdiZGwgecr4le4ysqioMaMhK5R4g2s+qf9FDYKcCaPUJGdWgSzKRUOV
	/GGzinyI0ocC6wzbXFgtnlPt3wMKU9ixeVCv/yFnhwZBlw0TaQ2e4rXBIs9kG6eVeeatX+sFgB2
	FGcNlbEG5lOJrQvHpdAQ/r5KDZ0Pc0+Z5KgpZRZR4wWoR8/v6/MTKCbGpla9TdLu9LufM98Yh8q
	jkLjmYhkaR9RB/d5J6cFLSEj56g826Hz628vYupF/Dn2OsMr7POq0R3pyoChPRMs862UQulg4SX
	BFf4WtqOtwhQ95W58+esCdtUC8qqx3vUmcFWW3egvE8s5Mbm+CjknEP4IDTcjDY8mqUWNbNJwNw
	KjrnFEXgtdmhzdcGPYYd7e5IJVfMobxNBW7oAgt8w1DD7fflumSVS
X-Google-Smtp-Source: AGHT+IEllritvV6gUtVnvU1/0n+3EqQhpY1ZhJDfrcQqre3L8Vnk9RNk1LBszLebiaD5fS4LgmqBcw==
X-Received: by 2002:a05:6000:603:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-4266e7bf04fmr18097453f8f.14.1760511514704;
        Tue, 14 Oct 2025 23:58:34 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab656554sm169458625e9.11.2025.10.14.23.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 23:58:33 -0700 (PDT)
Date: Wed, 15 Oct 2025 09:58:31 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Wenbin Yao <wenbin.yao@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	konrad.dybcio@oss.qualcomm.com, Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Message-ID: <w4kphey3icpiln2sd5ucmxgo7yp72twwtnloi5z7a3r3a63fri@fbebffeibb7p>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
 <20250903-glymur_pcie5-v4-2-c187c2d9d3bd@oss.qualcomm.com>
 <w2r4yh2mgdjytteawyyh6h3kyxy36bnbfbfw4wir7jju7grldx@rypy6qjjy3a3>
 <7dadc4bb-43a1-4d53-bd6a-68ff76f06555@kernel.org>
 <aO797ZyWIrm0jx2y@hu-qianyu-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO797ZyWIrm0jx2y@hu-qianyu-lv.qualcomm.com>

On 25-10-14 18:50:37, Qiang Yu wrote:
> On Sun, Oct 12, 2025 at 05:01:45AM +0200, Krzysztof Kozlowski wrote:
> > On 11/10/2025 14:15, Abel Vesa wrote:
> > >>  
> > >>  properties:
> > >>    compatible:
> > >> -    const: qcom,pcie-x1e80100
> > >> +    oneOf:
> > >> +      - const: qcom,pcie-x1e80100
> > >> +      - items:
> > >> +          - enum:
> > >> +              - qcom,glymur-pcie
> > >> +          - const: qcom,pcie-x1e80100
> > >>  
> > > 
> > > The cnoc_sf_axi clock is not found on Glymur, at least according to this:
> > > 
> > > https://lore.kernel.org/all/20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com/
> > > 
> > > And dtbs_check reports the following:
> > > 
> > > arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): clock-names: ['aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'noc_aggr'] is too short
> > >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
> > > 
> > > One more thing:
> > > 
> > > arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): max-link-speed: 5 is not one of [1, 2, 3, 4]
> > >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
> > > 
> > 
> > So that's another Glymur patch which wasn't ever tested?
> 
> I tested all of these patch and also did dtb checks. That's how I found
> cnoc_sf_axi clock is not required. There was a discussion about whether we
> need to limit max speed to 16 GT and I limited it. I may forget to do dtb
> checks again after changing it to 32 GT. Let me push another patch to fix
> this.

Still, you need to add glymur specific clocks entry then, to fix the schema
w.r.t cnoc_sf_axi not being needed.


Best regards,
Abel

