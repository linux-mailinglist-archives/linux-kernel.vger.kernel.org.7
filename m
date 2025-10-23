Return-Path: <linux-kernel+bounces-866924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0496C010BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6913F3A46AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DB230E0C6;
	Thu, 23 Oct 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOXcVqZH"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C1E311588
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221794; cv=none; b=RMSU1e2B9gu+R421kc04YvM2bh0pvKrWCt5ul/aOVOJCv3wYHJyAvLv5sAqMoPgMMM3FR+PM7UKq+dGDI7FBpkRTGhLQD0GMpPg7rAeqO8Uk3eiMc9HfTEbileO6UXWvL3I4ZVoOBtqnyI29VfuCDl59WRAEi3FalYgkC4joEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221794; c=relaxed/simple;
	bh=63w4Oubk2b9HQpsZ7UfW3R8E4afh0HvTI9mB0GUsn0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPNSyclQ1prCNLDoAGOkFNP3aT3WG5Zxb539d2YItGYBlTqRsp1JLQKbXC/GES5ZdyQoDKIGxIabr6gFzIvJ/mZnNVeeMBKwp+5y9yp4s9jWzecV/eIyJ75wWh4C1xpHhq5SsKB53O2oqm+WRVTqrNkoA+aN4Pa7swlLaf6wjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cOXcVqZH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so4206205e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761221790; x=1761826590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsMGC1kCHKoVmEzx/3J2+LZIPEEzI0s7H5COsJ+wzeA=;
        b=cOXcVqZHhzJPb/AikVkdp+qMVGJe9QiY31Nbinlo9vOlhEMPqgvU8MOmPvxbdGoxoy
         JvRwY/gYx7Dccd7bhyFm0r3eSlSBQdwrxcneWMaCiepgg3Qamt/4du1gzR145FSZvo6S
         1AjMllEwEa1KAIt1vaouxzWSc75MmDQYjy9ZqPEq2wiwY6zv9iWDfaS+RSTXSSoZ3xqx
         FvMF8jRGqt9Kdfhp9g2d8NWlLBQBu1F4xJtbvR+XKk34ndS9fz7fKMa6fhPhr6buUzHA
         zC75FbmiTvZnwbi881wcter8Ki/Fh5RuGMZ4fM668gjobQaMzpQOITGRDzoLaPVEUAm/
         StYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221790; x=1761826590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsMGC1kCHKoVmEzx/3J2+LZIPEEzI0s7H5COsJ+wzeA=;
        b=duCE1fSQFa9A2Ix1v9eg7+fbMcLSFW8fyyIDdE3/h28+RiDDpcjQq1kGapQCzmPw4p
         GRLsIXDy40heDIBE3M27lXjPioVz8ul1HWGaLQgeQxsqJbHMndTSiV3Mw+o8nX/1cRNY
         Aqn6oYdRyGVRhlZu/bMzJmLy/N0lkH6AD+zG6EglsFCFaZZksaqsUxttTFcCaAVcUYP0
         gsCNuJslvjqWZxn1m3m/0nSAJb2wu+/CpYax5bchPewo81MaoSOxB+tHt8zGOJ4v7MD+
         bLzDjtIP38MDDm+I8FpVlCVy39edcIxSVQ71OdRZH5kmB23VQCWnAeJ5TaR8eyIrs+bm
         CfqA==
X-Forwarded-Encrypted: i=1; AJvYcCX32MhYANhDdWR00uKpZU2NA/fNmFG7niygRaCbJYAlZwxrCSs1qS9Ld6dcZkPQty+vxIktw+XuyEbB9v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjytzLwyTy1U0H8aKLpS2YOZEAb6sBWjFXNxDwREwUuL5TWE23
	WQjtOT6uMmMrxBV+y37vFzE7h6hYZjUiuchgqea1mzKcwu/Tfc0fZs66NflKVsDiVkE=
X-Gm-Gg: ASbGncsfN268jLI62DcYeYX6tnnSTaflTe6as3k8QPlzf79mMTlcXlEFN01jtTjeqiN
	OEad35f/ZCmmN+sTrfQjw1p319Jjyqa5MItPzuCYBLt/mU5PBBK9BPBgADn1/wx59L2Skx9gcqt
	Q3TK3hba7onyMPnViiQA9+lw5AyYMFizjUaLfxRLl/un6N9vlVxoOZ79SsNFtO6cEbzD0EAizKW
	NjFFv5oSSJdsVrvySBEaA78b7aiB/OyZLnAdDi0wc2NX9ZSWHRFYpenUPf3JWcCQoRYu1DjdPuX
	XAeQBX24ZPUtDshN5odYeaJsyYoGuHJP+Er1cZuUTyg7miJLG8+N8Ct18RVl9xE+waVKxKQguE8
	e3lb4GExhtJIT5K2xtZmFTK7oj2ZH18QjJpQ4794+p1aIB180aNRkmads1fI7r2Ke3H0tiWtNuM
	lA9udY5A4=
X-Google-Smtp-Source: AGHT+IHFjzVLSym4Q6bXgkW+gQE8VmDlbUGdEH4H/I7XmfcC+FQGVre5Ex5Mf79etOc4+NZ/f0kF/A==
X-Received: by 2002:a05:600d:8394:b0:471:1717:421 with SMTP id 5b1f17b1804b1-4711790c587mr119581255e9.19.1761221789853;
        Thu, 23 Oct 2025 05:16:29 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4378cbesm90781295e9.16.2025.10.23.05.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:16:27 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:16:25 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Subject: Re: [PATCH V2 3/4] arm64: dts: qcom: sm8750-mtp: Add SDC2 node for
 sm8750 mtp board
Message-ID: <h6cpk4z3q2h6ymy565dytbza5mbldruhctg36utzdwjrd6ohjq@5rslxi2tm4z4>
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
 <20251023112924.1073811-4-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023112924.1073811-4-sarthak.garg@oss.qualcomm.com>

On 25-10-23 16:59:23, Sarthak Garg wrote:
> Enable SD Card host controller for sm8750 mtp board.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>

with the card detect gpio added here ...

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

