Return-Path: <linux-kernel+bounces-730676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2901B047FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6A8165B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E5222A7E9;
	Mon, 14 Jul 2025 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+lEts+O"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC4227EA4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521986; cv=none; b=cie5A/RSnOtR1FyhHyNpBVMLhBpSNK0IPMA+2cVUyoSP36gBwFDDVOdncso8EV+0ITW1q6CQKqVPrQ4bDMkK1FHCe72eMRP+hc3oJn4Eaql8TRb19BdzfUn5XWauA9+qQmnXLItQ5nePSObTa4kCVq3SfA+AApdo/b2b44S0vQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521986; c=relaxed/simple;
	bh=5cSCYdKyaKnlsB59d7LA/sqcozRwuYbnW6S02DziChQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P9k1Jc6sulWZibZQPlOyH+koekLd0fr1M46PWrxeyAER2YrKgD0To1TqYu9FtnR+seoW0WPeowQ2Ji/ewMoSazM3xzJMnRJVf0RvYNfgWknS8YxD3ZjxMDUtzHvl5JAG44KTnj7yS4Ph4Az+YKeN5kzr3pr4WIMU6eEnqbMBY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F+lEts+O; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61593d51267so68994eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752521983; x=1753126783; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=urOya2QD0PAv3aRyUi92qVBccHFN0GyUQM4mpsavCC0=;
        b=F+lEts+OFVJIPuwVRnJK5F1pfmdT8s0b33WyPl3yTSpNzYc94+Ra3pdGqSBX9oXkZj
         zc5FeOr9OPpCrRH3OUAE2AHItRNZXv0JzsCwrS4IQlZexQ/8ObfrLmgTilXyv757B5rS
         sqTbM4JjI/euxM6GVNOWtBwz4PURIWU2GnNKOmguIxcWb2WuED7OQjtuH7NqUTcKCrcL
         56GOombgsGoU6TcZCI8HQpOlxRl1dEo3smb1sYZGU5ks/yd7qjJOcwAinl9CsqCsUncx
         V5T4qgOOy2+0ZK5j+7fhFq23EbhI9FM6PgC2MHLNaBRI5iN7mCjmUfEL5q7DQXkvT2D6
         vpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752521983; x=1753126783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=urOya2QD0PAv3aRyUi92qVBccHFN0GyUQM4mpsavCC0=;
        b=BZLWlMEhCA+u47RFXM0/10CSvADJQpkXJWVTXTcaUVel3ZypCSfakZm3x9OnddG60o
         JY8HXetZiC6jvsuyFdYsIPBq1EDPWAnjoFG1xrPby+eGgSZXLXqE000l9RW6m1Wlogf1
         IDIffiQsFEGMUd1kZgBSjEp+ztRfp+6wkuc/wUWC4mkcBPYYMpzDxR1rMMpBrWFA4AA7
         w6q7Z714HbrsFW8lKNnB+5HGrbveOsBAMipYPdKhEuoawq68YajUsnZeO0uk8AtrS9EL
         41RSPOe5jfxXdsaPwXpZAVdkBkETjNW5fkf/SGJ8guDr3WZfDgMlh4hejJWC9f9WQKK2
         zKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxsRp8+GSnP8gq3jS9rD3qePJKTRAKIcRgr/qISivqG/LDVBNyz61iRScoETDgtGyDlnPitvKkkjhGaZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTwS6SAt4KZgjLu5+9rMGZReLklqQpnZ4ZfRjcLTSVIP3Dswt
	hTayPN8ltr80T0qWDMZWzuJFgcfA4Jl9dfiDDmjruzZ4C/2212aUm+sASSxDr+KsM0c=
X-Gm-Gg: ASbGncuU+o5jZuNSXnNriC9YnWdk53w5VdWIKnrOb/NLFaWi7kB9ZhS0Gr45B/yCjFT
	fk2KFR5NV2zY8II4QTQ2IF1ADuSGvhLYOkq0vfz2WXKZvlZJxCJUPNA4h06DuvT8UuNZr4IDgln
	0Xem+dX7K57bgElfokJmQo+S9HoXzQMTgpmT7b1yPHhkrSQw9GQsPZKpawK0cSVzfsWE1aRqD37
	NL1ccGsft6qbwEcjuZv94yqtf6wdOp+CgbXvB8irq5aBoZ8sT0Q5/f9yZwYQojTM8gDLAMva1IM
	nN3Qs3jixeLsrNQ14UlrN1N4yrnhaqWeUc2xJSczJVn+pJ/XcuYN/f38IWownlnFZzfbp2b72Q9
	JqMtM7iafF8EigUglYMmOHw+KH6mwUA==
X-Google-Smtp-Source: AGHT+IG9YCfy/a8BjNGBo1GzQjJuR8GmP8UR9cv+uwP5yDJexmfxPdWGAOu8EtDFH9IyIV9EN6mZeg==
X-Received: by 2002:a05:6870:c03:b0:296:bbc8:4a82 with SMTP id 586e51a60fabf-2ff2706c894mr10579426fac.27.1752521982792;
        Mon, 14 Jul 2025 12:39:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12b62e8sm1674368a34.60.2025.07.14.12.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:39:42 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:39:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	Le Goffic <legoffic.clement@gmail.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Subject: Re: [PATCH v2 09/16] perf: stm32: introduce DDRPERFM driver
Message-ID: <1fd92742-0958-4f64-8e50-4d0595fe74eb@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711-ddrperfm-upstream-v2-9-cdece720348f@foss.st.com>

Hi Clément,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Cl-ment-Le-Goffic/bus-firewall-move-stm32_firewall-header-file-in-include-folder/20250712-030518
base:   d7b8f8e20813f0179d8ef519541a3527e7661d3a
patch link:    https://lore.kernel.org/r/20250711-ddrperfm-upstream-v2-9-cdece720348f%40foss.st.com
patch subject: [PATCH v2 09/16] perf: stm32: introduce DDRPERFM driver
config: sh-randconfig-r071-20250712 (https://download.01.org/0day-ci/archive/20250712/202507122125.eve8lg60-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.4.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507122125.eve8lg60-lkp@intel.com/

smatch warnings:
drivers/perf/stm32_ddr_pmu.c:380 stm32_ddr_pmu_get_counter() warn: variable dereferenced before check 'pmu' (see line 376)
drivers/perf/stm32_ddr_pmu.c:380 stm32_ddr_pmu_get_counter() warn: variable dereferenced before check 'event' (see line 377)

vim +/pmu +380 drivers/perf/stm32_ddr_pmu.c

73af3c4ba702d7 Clément Le Goffic 2025-07-11  374  static int stm32_ddr_pmu_get_counter(struct stm32_ddr_pmu *pmu, struct perf_event *event)
73af3c4ba702d7 Clément Le Goffic 2025-07-11  375  {
73af3c4ba702d7 Clément Le Goffic 2025-07-11 @376  	u32 time_cnt_idx = pmu->cfg->time_cnt_idx;
                                                                           ^^^^^^^^

73af3c4ba702d7 Clément Le Goffic 2025-07-11 @377  	u32 config = event->attr.config;
                                                                     ^^^^^^^

73af3c4ba702d7 Clément Le Goffic 2025-07-11  378  	struct stm32_ddr_cnt *cnt;
73af3c4ba702d7 Clément Le Goffic 2025-07-11  379  
73af3c4ba702d7 Clément Le Goffic 2025-07-11 @380  	if (!pmu || !event)
                                                            ^^^^^^^^^^^^^^
Checks are too late.  The variables have already been dereferenced.

73af3c4ba702d7 Clément Le Goffic 2025-07-11  381  		return -EINVAL;
73af3c4ba702d7 Clément Le Goffic 2025-07-11  382  
73af3c4ba702d7 Clément Le Goffic 2025-07-11  383  	pmu->selected_set = GROUP_VALUE(config);
73af3c4ba702d7 Clément Le Goffic 2025-07-11  384  
73af3c4ba702d7 Clément Le Goffic 2025-07-11  385  	if (config == TIME_CNT) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


