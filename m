Return-Path: <linux-kernel+bounces-798795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CDAB42312
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48478586D33
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEF8310654;
	Wed,  3 Sep 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6A0lRSQ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEBC30F528
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908316; cv=none; b=m+NppITYuER8XhNSHAzac2g1LyTS1Cpy/mjv/dnvzizrtk82YEmpO0RIQW6QZKp1+/oaEhCJ5dMMpEGkPcwemHnEENRDRpzN2sNyeohtXynqwoH8uzCubygHDWNtshDJ3brOqTkEGcu6MC+ddQks9BIMIBChWBf5wlqZiIKgVSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908316; c=relaxed/simple;
	bh=p1lxtpJ7TjvFoHPJ/hZ3029ZCfEe68+gdc5pXFuSGH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXyTsoK8BH/vZqHrNfSOXgmcm4jqkieSIPOLcKSmdbgStQhCalas/2VlL10Ka8Sz5xrQCGx0pc6zCrlrwwZtaEaE9ugqUkcN2CehfB3dDK51QNSRJs3ZXllzjEsyLKn3UJK86gFmnWxd1reXiMYmFPjhkeAcKb4ExeKXDtTFLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s6A0lRSQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3dae49b117bso1579867f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756908312; x=1757513112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QK1Plguf59MohKiPDL9B9tJ9p4M4VouT3+3TgzQ44t8=;
        b=s6A0lRSQEJ90tneUCy4zUGJz3L2E5jUu9WsMzIfv6g50o0+H8hjACes/xhJphVACrJ
         wY1XRLApmYh3RopjnhuBLvNY3qAYVViMH8S4T2lxPJTesKnZsjZiSxvGQlqw6MOLlZAd
         spHHgGYKFIqxBJXUa814BPmEowiwB6LyLnJmS5ReefQgeKwgRzD8qZY3cALUKn3qHYc1
         fBwZboS/iNUwRVy51FHS0tecA5Tr0p5Fi/fZEynI2SpJpN940MLe/WzIso3NlGan5fXc
         yPpYUIvYfnSNLVtFdXcWmJv1TshOwEhfJDkJobAuuFhJkRNvIxBDQSqsMlkOBGZnZn7s
         RHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908312; x=1757513112;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QK1Plguf59MohKiPDL9B9tJ9p4M4VouT3+3TgzQ44t8=;
        b=O9+f/ndTIIze00Yebj3mpNHu6IAy8GV4VNQXIRK2ZLOvOLs3QFW4TDvJ7ENekpdBuJ
         IDcKcUzuSlMXnTFMIn7cWwLD2l14moGgzq4aGIl/B/CeFfdC5YTu1We5oqQCRqnlOBmy
         4OuNaaTz+5L+lvLRBVJLTNyLfOzTLeF4rG3RcTNg8jWpP9shRgcONxR0HumSBS/CAyIF
         HcyO0aU4beNObgh+9nGIqAHCzG9Y+0J231zFBZGVj8JQefI4zeFhSLwVsLEzf/IEXg0w
         msXszBZpOIpT6viv4QD7YMvrOy3O5zN/tcZhJS/C8QtOIYAWFtarh5ZBw5Ek5MZ+WOe2
         8flA==
X-Forwarded-Encrypted: i=1; AJvYcCU3sHNUiiGHBSOnCAaJdQhgr+q4pX9aANd6DzwVfAeHODIwmVLAF93aqLQAcuJYkstQMiBZwOQR2lGxdl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qJlUhdTwRHfbYWrAXX2hcR9XiVA7DxgKwrmSElS88vH6/bEH
	Bxt2sC3ZBsC3vxJ/ZM0z2Lt+LLInAefVVeG79DiQCWW4zsZEE0wr57yXvGT/K4o6sY4=
X-Gm-Gg: ASbGnctYx363PtHyO1WUUBIAshDvkKN8wIskpLzM3tRrL+XWJiKWFfTtQNMk5mxJKZ2
	K8RbuSlMGenQXeswLgIlp4bFx2PzoL2Ll46LhxYIZR8EPAg82VzuUFN9x6ahPkbpkkp3mDqja30
	gcRyzv2kK86RYekBSFdWZgVIi3z8NBjSHnnRMmmm8sNjShZVMRnqf+z4wfVn9GWuMi8+NGHKl0c
	hsMm/BH17MUTDZ5HxGV4+FaB3Yel5AjLmpOxLyO4R43tfcELcJ1HHjj720HAlyaKmQvocvzG0QX
	Q3FL5CeI6q3rrBcK/CQ3Zpebh1uaIqEzQ521w5rv9LVI/ntXLq1HjQu4hZqGtEvwXfwLVXc+Ftr
	qwQlY1m1CZjZdDzzPHJYN0YQJckOfycpmIpi2GHUgddINE1/Xb4xcfMANp671eHOOqL0ioFwHTr
	U3lXpL2l+uqdZ9u1IgwHOY7z2xwpP5cw==
X-Google-Smtp-Source: AGHT+IEZMZforlja2xX6xreLhIbpAVhCSknwT4/G7zI8fcA9TDR7jhhzcqogfHqvrdx3U1dTW1cIhg==
X-Received: by 2002:a5d:5887:0:b0:3db:f9f7:df86 with SMTP id ffacd0b85a97d-3dbf9f7e8d7mr2886230f8f.61.1756908312422;
        Wed, 03 Sep 2025 07:05:12 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6fe5sm323422865e9.5.2025.09.03.07.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:05:11 -0700 (PDT)
Message-ID: <680de02a-6592-40a6-b25c-4d8fa85c4e81@linaro.org>
Date: Wed, 3 Sep 2025 15:05:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] Peripheral Image Loader support for Qualcomm
 SoCs running Linux host at EL2
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <660c2594-9a93-450e-9a2e-17ef6b4c696d@linaro.org>
 <20250820112242.usd4sdd3avxdlcas@hu-mojha-hyd.qualcomm.com>
 <f5582304-8f55-4c3b-b752-9cefa1e4df96@oss.qualcomm.com>
 <b5a0ad0d-ceba-40d3-a111-0831c4538cea@linaro.org>
 <2g3iwc2en6wh2ucrsth5ontzdwqr7tr6oplxjnfdjsy3lwyyfe@l76frwiadgru>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <2g3iwc2en6wh2ucrsth5ontzdwqr7tr6oplxjnfdjsy3lwyyfe@l76frwiadgru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2025 15:02, Dmitry Baryshkov wrote:
> On Wed, Sep 03, 2025 at 02:31:55PM +0100, Bryan O'Donoghue wrote:
>> On 03/09/2025 12:56, Konrad Dybcio wrote:
>>>> Can you try with this next-20250814 tag ?
>>> You sent it on the 19th, so it's in your best interest to run a quick
>>>
>>> git rebase --onto linux-next/master $(git describe --abbrev=0)
>>>
>>> and giving the series a prompt re-test before sending, because there might have
>>> been incompatible changes, whether ones that would prevent applying, or break
>>> things functionally
>>
>> I can't even find that tag next-20250814 closets thing is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?h=next-20250814
> 
>>
>> | * \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \   00062ea01d35e - Merge tag
>> 'drm-xe-fixes-2025-08-14' of https://gitlab.freedesktop.org/drm/xe/kernel
>> into drm-fixes (3 weeks ago)
>>
>> but patch #9 in this series stubbornly won't apply to any SHA I've tried.
>>
>> meh
>>
>> ---
>> bod
> 

ah..

I fetched -stable

---
bod




