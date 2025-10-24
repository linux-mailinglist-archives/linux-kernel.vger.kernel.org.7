Return-Path: <linux-kernel+bounces-868889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D647DC066A5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F6444E66C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB431A561;
	Fri, 24 Oct 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkRXA/Qd"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF031A800
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311555; cv=none; b=hZ1skhqtMcSNXKRx/DT0ubj7o0AirEarGMmK2Gmc4iemlg7Ruvdti3tRRs+lOaYpw/5zhsVSiHoAPU+/zrrhm8rYfqqcBp1yMfRrbNgzamX0sh1b22FfnV38jqLYrikIfwI6fcT7ln5pZiZfSbgmQiDS+2wi2Tl6Bgl4kYSGZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311555; c=relaxed/simple;
	bh=OKClficrmYxMDAQrUO1h0eLa0MMRKmFd9IjAbIgxwhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVC9QnLUFEbX44NO14LliwC1YN2SqXh4KgHfECFvl1iRm595SyHz6vrMkjJfWBg0wkxpYScCXkuMgVIh1mQEyYcGlOwHPpZ8VTgJ1juLiL7TjTMx4w2JarX/x++sFVCQs2dx4w7E/tCFjU0EiN1Dt8VcwE6VJmxK4JYFnVXYaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WkRXA/Qd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so12019785e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761311552; x=1761916352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qvr6GH29Nfx+EsRdL+4o2+h1AfNCPToJ8oczIokC+Sw=;
        b=WkRXA/QdNtxtJrCFjqQzLYldSPXwZQjNebyQX91crgckJ5q+eHO1le1WD2RdflCN8W
         S1zdC/jJj0gfU9mmCVhYnBQpJy2rnotU3Pqj9wKcVBW8NoBHEHMk9nl0gB6pzjommuNn
         ADerOYKxjM7xSG/9pkLgnIqLsKclnp2yofV8ikP7DBOFIFCuQT1Nui5OYnHojxiEmWgD
         BCGihQUWpJE5A4OqEDr3f4nsly7lF5AdQ48BGFAR4FMMdQ598Wq7MNIMi3raZ6/TK7S6
         KiIlCLs4ip8eg/ri5BkVSX6gOAcY7TJD5SllQ07gk661yBY3AHujmNR4YplCaE8VCF/Z
         cdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761311552; x=1761916352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvr6GH29Nfx+EsRdL+4o2+h1AfNCPToJ8oczIokC+Sw=;
        b=Dyq0FTKM9+ZuqX8nzEC98MdZkiHmrctVj5hGfLXJYdiUVUskUoOMWJ31hMbhwThXUY
         MbxbAWT7UQY33Q6JFHKX6VmAm1CdygF1+dQ6rxguG9pZnXsVI+C8/uCirLBfaWUVMlWn
         4XbKQWbgxIuZ7owjWNNxm/EGpVkrbmvFSyeNusmxJqiA4SDq8gCLZsYbrIQMem52/Yyt
         CFmTJv5hZBQRYwtmqLv4KmQoXli0bmxy5Ot6PhmYj3dJL30/3MvBh3TY1k5IFmcRiqJs
         JfD6/o1qyQtQ1fvxd2jBU3LtGCLIEZ/6dp4J82kQXDN304AP0OWlzaoJU3MWG1UPjcFf
         R2qg==
X-Forwarded-Encrypted: i=1; AJvYcCVn5qTlVQtb6A2L9NZx4aytBBvnfu5PaJJ3iPBCcmyndW8oY6pt8WCgVd1oCefnkQ0oWsOLTdQFGZfAuEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxauUjkVPhnA53weXSjdIqsfviqjtEgLHp4VwJo6uUmecYhM8K
	ijx580Yw+7QB0EMQTo2qBUTvOD3ekGJ/G4Bdo5hD5y799jWAhqGhhXxymvfJ+4BjBnk=
X-Gm-Gg: ASbGncsv3n+tu4plY53naAPTWCj11BJhXZhWvWxnTHsV034a/PleGUggSTC3kYJ29z+
	Wwha9kxL/PGSkXKlvoy4DoTKGh0R9nVmHWm9QY0kWHhx6asYYgqCsv/nGVL/sUHCRPFVxp4S4Q2
	lLL4+873P6ZNL9IfPjY4UkVhp07RHS9Rr2990h89MhHBgUbqCyn43UoGuZm84w44zIhNqzfX79I
	qxfcUuibktIZFb7A0AQjpxMkT4phBpHJZFza0JmSXxhPcj3AkZOSoHeeH//honObdJ3NFNS1k7v
	sYRZlPLJbUfdJd9bss1aAyLDX8HXjxfjLPjRpc9nCrri5WTplX+xnr76JGVTFHpQOePm1fbvRO3
	M9iodSN1cg8KVFJJRg1U2UTM3sM41e+EeDngdnHgu55VgbstI2pnfhl1KLtm55JFgrcnvCdMfFo
	WRfv1KlC0=
X-Google-Smtp-Source: AGHT+IF+1xCry/9A1ZHNOGG2pxcFEoxq6SJgtHoESPq3SvPRxcc9P29yK7lzj+svNHJcxN5sWMsJew==
X-Received: by 2002:a05:600c:4f08:b0:46c:e3df:529e with SMTP id 5b1f17b1804b1-475cb03021dmr50372855e9.19.1761311551830;
        Fri, 24 Oct 2025 06:12:31 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4342368sm156180605e9.9.2025.10.24.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 06:12:30 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:12:29 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ajit Pandey <ajit.pandey@oss.qualcomm.com>, Imran Shaik <imran.shaik@oss.qualcomm.com>, 
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Subject: Re: [PATCH v2] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
Message-ID: <mz37jryjovtqz2cqeitosbeznjf6px7444jqxmd3ccmwpbdruc@y5ms43b5wm5m>
References: <20251024-sdcc_rcg2_shared_ops-v2-1-8fd5daca9cd2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-sdcc_rcg2_shared_ops-v2-1-8fd5daca9cd2@oss.qualcomm.com>

On 25-10-24 10:48:45, Taniya Das wrote:
> Fix "gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
> boot. This happens due to the floor_ops tries to update the rcg
> configuration even if the clock is not enabled.
> The shared_floor_ops ensures that the RCG is safely parked and the new
> parent configuration is cached in the parked_cfg when the clock is off.
> 
> Ensure to use the ops for the other SDCC clock instances as well.
> 
> Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>


