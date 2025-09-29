Return-Path: <linux-kernel+bounces-836188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5BEBA8F59
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDE9189F293
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D332FF678;
	Mon, 29 Sep 2025 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTA98byZ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3D2FF676
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143760; cv=none; b=q9GGskRwgY4K4C7Q/sSlCezYWRv/DBCF5dupsL0oXpZzn0QkyqkGL53N4o9kTAAnZTubswP8wrqqaUYcvIu9BYKjkIkijJDePitkAs79ykAsnt3TY529k4yzICJrk0eT0ZQxPlC4ltoDwmATHHNxsde9DrzZ1EXCkRcvpZ9IqCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143760; c=relaxed/simple;
	bh=GCP8LuYtl1jmZq2NZKQmVEw9gQOGAcyHtezJJOCLTAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpQ7EsNrJq5No60lWPND3jZiZh267jKcBG1DZJrrUo0KosRBsSpEiMcwIVGmYxIxNFFFcAdTXNAtmv8MIkXDXnvLa8GZRJ6kwnnlvOpZFpWARs8221hb0nQ17NgOcHplpuK/B5gSSd2Kp42MS3w1/b2NO7/dfdZyiUvz/1LHmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hTA98byZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26c209802c0so47038405ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759143757; x=1759748557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ArXlIKa0bCAPRpe0CickijlhXS7XHZf7jcmbVv++sWo=;
        b=hTA98byZ22UWb35+btzTO/cP7WX2yWJUQJdqVXOaWI4yfwh3itcySFQZORmWu5BZEE
         mIxzN4NcF2TJHkFs+aXwMBacELqodzwOXFW0UnPLbwl8PFOgZ5RZL9AgUXYh5hEHNPK4
         wY59vZxyerFGgBN9zDbFitnnK0t4Z55jo+9Ou0nIOpr5JeFMa0mvlNFsewyqC8gN6Aht
         xPKlL+u/pkGOtNm4v56I5dYtJkgBxFemFBrR22bJzFF1m0aJ0MqPGZV+g/DKCpdVQGZB
         p7oNzAfJEFMXYzNEy5uoipsB8cjB+0rJIUBtDASZLEHeByK1kGoD3ct6HqwpfH0GQhDa
         gaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759143757; x=1759748557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArXlIKa0bCAPRpe0CickijlhXS7XHZf7jcmbVv++sWo=;
        b=QGyCUVZDHoOdfQq7za6apFXSTOFQwBEMZ6Q0P8ApFMjjYLQ596nUUzf0TOGbXlbXHl
         C4XQXAlRKEOTSj/hbK5utpDdbgtg+ilbqhzMq5pMFX0yvuZihUuZrieFyrMdz5U7g1vj
         bCG6PyDpMlxKx8JbE9rxw/xl088XAlx6RTJwKuHUbUzvakNV65Q5ZsDaGkxJ/3Y6cVZF
         /7Vr5zQ5oVbsTD2gOtAlWgrNOdtu8EjQxBTRc5HXRnMM+ceQwbA+s+zZjkNvPyRrjNaw
         o+GCnOVoFnk2BzJt7AxJ13tbTzMlEwsc+13NPlEoTJzX/kyoSRESD3twgiGHULy26aIf
         N1qw==
X-Forwarded-Encrypted: i=1; AJvYcCV5MhOGPl10XhYGz5QQLUSFYYlXnQ4Kro5QK1gjDYDl5kuZccQG3itsqXeA1c0mr/r4fWB7peQUAq4fUtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyqXsPnUhAFnXwrul5+LWTDolo538tFlsM05qTHsMnNpWctlOM
	3h16Cd1T9zRU4gj+0DGuAzAuey8lzII3b6173fVxNNbTFixfDmAyy20TMk4zVE6WtbE=
X-Gm-Gg: ASbGncun9hEXRaak5E2E9D3c62iqRo8id2GPJJBaxQaR/zWRglayXarO4mm1t8U14aO
	qHR+roghAVjpRPDKewhHcUCNRDHB3vC+LXuZ299+g3SoBEXcZKRymlB8TCoKWPJOUssz2vQrW+q
	/+nTJiNfLvRaZBmD8udAWleWkF6g+DLpMtH/8uN1M34cpg8ovCjaEmGzkX4cKAPjAtpAn7yI7n4
	viqIC3NzAgRJxKZbQ9RkACeP68qu4mPxKTzp9NpuxozsRIzGt1OYs3fTofEtwOy09yhA+cRn2xx
	iQioRh2drd/3tN2tbAiZ+edUDrB67WKTwAXAQOvwhjizR6KHhv9Fh/WUYWKJ3WagjsQsxAKocnr
	REwE+D9GRW1MBNoIVlMmMsqXz
X-Google-Smtp-Source: AGHT+IFJ8tBd5DbfKm01y+6YhQUicmi46JD7jPOYKxXSxgRsT1oHLX0ubEnEv3SeXFYfJc1oZPUmzA==
X-Received: by 2002:a17:902:c409:b0:269:96db:939 with SMTP id d9443c01a7336-27ed4af3882mr193698795ad.58.1759143757073;
        Mon, 29 Sep 2025 04:02:37 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac274csm124914185ad.134.2025.09.29.04.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:02:36 -0700 (PDT)
Date: Mon, 29 Sep 2025 16:32:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: cpufreq: streamline find_supply_names
Message-ID: <20250929110234.ukgwsnxyrvsimhst@vireshk-i7>
References: <20250915135954.2329723-2-thorsten.blum@linux.dev>
 <CAH5fLgg0_NBtfVMNBwXOe4BpyUKz_S=v0CiDxyKNYZcS9j7WHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgg0_NBtfVMNBwXOe4BpyUKz_S=v0CiDxyKNYZcS9j7WHw@mail.gmail.com>

On 29-09-25, 11:38, Alice Ryhl wrote:
> This is a pre-existing issue, but ... this treats allocation failure
> and non-existence the same way. That sounds wrong.

What about this over the current patch:

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 224d063c7cec..e509b46b64c7 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -26,13 +26,17 @@ fn find_supply_name_exact(dev: &Device, name: &str) -> Option<CString> {
 }

 /// Finds supply name for the CPU from DT.
-fn find_supply_names(dev: &Device, cpu: cpu::CpuId) -> Option<KVec<CString>> {
+fn find_supply_names(dev: &Device, cpu: cpu::CpuId) -> Result<Option<KVec<CString>>> {
     // Try "cpu0" for older DTs, fallback to "cpu".
-    (cpu.as_u32() == 0)
+    let name = (cpu.as_u32() == 0)
         .then(|| find_supply_name_exact(dev, "cpu0"))
         .flatten()
-        .or_else(|| find_supply_name_exact(dev, "cpu"))
-        .and_then(|name| kernel::kvec![name].ok())
+        .or_else(|| find_supply_name_exact(dev, "cpu"));
+
+    Ok(match name {
+        None => None,
+        Some(n) => Some(kernel::kvec![n]?),
+    })
 }

 /// Represents the cpufreq dt device.
@@ -68,7 +72,7 @@ fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {

         mask.set(cpu);

-        let token = find_supply_names(dev, cpu)
+        let token = find_supply_names(dev, cpu)?
             .map(|names| {
                 opp::Config::<Self>::new()
                     .set_regulator_names(names)?

-- 
viresh

