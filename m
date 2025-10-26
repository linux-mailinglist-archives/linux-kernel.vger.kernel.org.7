Return-Path: <linux-kernel+bounces-870525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F0C0B0B8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7873AF168
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74642FDC4C;
	Sun, 26 Oct 2025 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTChXUf7"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179C1A0BD6
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761505360; cv=none; b=UEAnkGl8SQrdvH4pHnwltv1aonbUT7vNo94Lon2Zn+m3ffwqF/4nk2sw4yS/4UZPiSCkxSS17+d3PEGJ7pKUc/nZqW8Q2irF+17pxyw8i72FjA7zZwtZdJz28hr4w6Ln3nxqgYdkWbIHiEHb/7+HPFcvDNGPNDMn3N/GfrZpQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761505360; c=relaxed/simple;
	bh=2Zk64nIinYp75+zdhYO2p5F5t8LO7MM1BYxuCH05Bsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKyxw46QAsriapUghBS1nEJtVHjyYkRjBUn0dvHPBC3FCf9sdYjGrYiVUlbHRUsOv2fixEj99CZXHgBq7yqe6EfUGZg8rZr75utx+cJ9IDXLb1Xx3shu2mVq4TJJ08ZppfsQQBXeJdWZZRqL8Un6X04SCmzHbSCifWvnreiwBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xTChXUf7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426f1574a14so2504386f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761505356; x=1762110156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTgQLFpDzOTh0ZoPt3i/pwuz2uzBGwVH7SJBsVRuI78=;
        b=xTChXUf7p6MpBXoFbVAcFVB9wWym2dF7Dd/8VFmhZnZdnfCpYA+k7EKRndFOgJqTqh
         Nzw+W7wYIEjYxbMjSeuTnpAeykfIHxnLJUc3C2OSxjOx5lMug1qmaJQaUjY6RnDqYZRc
         M4nD2JsTPK/3NzTDFoYDdDeNjDCnGNFxkxGMWr3q2PLr1lXlH4DSxbOBryzDe0EfPZMX
         UmjvIRM5l0sDDKy/w6kiyOPzfiUJNerI4Q9Pf4ipYsfbPRu+8oZFgZWs3V/H1gyltrCp
         XHZyoyQHo6+drdZJKLs5/B3P52yDwX1qFe3LNp8QY9Vxtbdwk2enfvE/MrjmJZ9+Yctr
         InwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761505356; x=1762110156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTgQLFpDzOTh0ZoPt3i/pwuz2uzBGwVH7SJBsVRuI78=;
        b=bOm6uzn9JJ4dPmPWwJscR/cPXF3DgdbEuLxxG5a+CxJoZ7dCNTWS2fz9fH/053aYzx
         Snfv4dh48SZ3FOcb9wNP/L3Or89bQnaU81HdLgqEVksanFF3cUq5sNYQ5ey+64jmZ2YL
         5w1x1YU2YVosafH9dAaa8UisGn9T2NP3G28iAc2oKmxEw4WFcRSh1/DsG8RbjncL+/XX
         fo5MwJdi4+RRZxjPut2wkEqMg5l50xbvlbytYrPyPpVI62BRwQ6xxv/iqIxXsF06dy7x
         m7agZsjUePmYb4mLV9zei1ibm9vPPt5rAKxzx9DG6BPwwSeLuEDJiiN+MF7TbjUGS2uo
         V4sw==
X-Forwarded-Encrypted: i=1; AJvYcCV9sh4BpiNzwcJCnQn8Xg/yiRRdhMf93OqNyiuhvWCQGNi58beI/dLlaATCl3GSWDLHv7KfEIfLdA2WKIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy94ATq7/GUTLVsFqIRerzsbojN04wsmiSABZZr35pqvsCOW0VW
	Hp2lcGZfjLsTks7uW4o7FF9Y/0Kk+kZKdXdwhFwtmjDiCI9RUoQBdsfO+UXIVzI0Flk=
X-Gm-Gg: ASbGncv8IPxMB0/R05esoG9mVoAiBQTLhB3tJS6CB5BcRTlggL0nYjyqE2vdSMrWjSu
	28o8DLnWU8djp+MAzU6mHAT4poaA0OchkdGVolaRqPWYSkWwjaGMnPlHRBHamhGFck6WkLpfsgg
	szILNMX71IjKEWanH/cfCq76kKHjLwwuDz7qQCNCBhzNU2Mc3kzqzG8UsYXVevcT6msBmgO46ba
	5eHl+v+zI9JN7Jiqq06DESo2CpjWTNEZ9gyJ/JCUDNKuYPFmpZVvwmRyv2abxqi/pTpeiHkZwgn
	kk5BCjcLSGIz44ZeZ9jl9Y7AW572sL6uqhQmownk/iaF01s1ifu8vpxgOGpu444d9PMyG+ri2CN
	CxqSh9vX0H5cikY50Z5KxCo5Oe7W0W1H3Ch97we5cnJQy6h6fh6y/HFUjMqeHa+6vVd0/yMnRRT
	fYLaqpLF8=
X-Google-Smtp-Source: AGHT+IGxHR5B1DhcUj3Sg4f6YGF6eRKC27Zj/+bUenMC5vwB5qpsgIYVS5DHdOJagXUhkL1MGGao8Q==
X-Received: by 2002:a05:6000:22c9:b0:425:8bc2:9c4b with SMTP id ffacd0b85a97d-4298a04068dmr8285438f8f.6.1761505355881;
        Sun, 26 Oct 2025 12:02:35 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7badsm9698313f8f.7.2025.10.26.12.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:02:35 -0700 (PDT)
Date: Sun, 26 Oct 2025 21:02:33 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Subject: Re: [PATCH V3 2/4] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
Message-ID: <wqkmiumkn4mha26jlky2o2dyplchz4c7kjlhgkictlep3gjoga@6kxhawbf2ytz>
References: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
 <20251026111746.3195861-3-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026111746.3195861-3-sarthak.garg@oss.qualcomm.com>

On 25-10-26 16:47:44, Sarthak Garg wrote:
> Add SD Card host controller for sm8750 soc.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

