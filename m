Return-Path: <linux-kernel+bounces-885549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE783C3348B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1E418C4A5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53B032E69E;
	Tue,  4 Nov 2025 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIxwiQuo"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074632E741
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296014; cv=none; b=jCO9/9qW01v8HucRDdrDTRChhPyy+Ysfx1eUdLb0bx8FVnbmtDf0J25yLPKCRRQHjrc3OFagThol42U06aGKj+S4NteHsrgMMM6uruxbaiG1PoBYCYE+sYaHNXKGTeqT9RtEpg33XBSrskm96uYT2OnmY3lBm0JH3Ef5vMC4Zy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296014; c=relaxed/simple;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbwzkwSDMZjuwrJmdXxVAOcyXmwHUck9gn75sfpDGU1KCWVBAHnNock+EyHcaxT30ZAgFMBRBHJZxCM1Jt41UNKuSlWhk8kpS6RSXnFbuvkVQ+DaRNvOG9wxT/2lvH1NI6BrhVoIoEpSiyTUc3hY45mLIsR9Wqg8NuKkGdB9ig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIxwiQuo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8a3eac7ca30so473602885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762296011; x=1762900811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=BIxwiQuoKiUDB+tQ7bqL2XSW6HHoZ5xxbghVOMUF7/CLWv0S+hK+BnjXWHIcmKc096
         iHVvOpIR++8nk9mrZTI8y0J/ipp6YVK9qP7f2vpqnWBx0Re6cidqJgu3xamlEYqji3Sx
         0aD6XRrHtMJolHlDfCpFeSywgqATGKXDJENNho3ghNvA58KcJBhzzV0NfDXF1NMCd1VX
         Rr7ePQCMb+5Lk6x+zzYC5QOUf3cjnYkXA8M/3JMCU8w/S07lUo0chDLgvlultQ+v8upA
         Lq0zTC7OOYrikZ9vOSXeHQPoytdtbfAnrwrZv0vtIumHSFVDeg72FbjON/aR823YS3eb
         QzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296011; x=1762900811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=wdrong8AFyangUOmwtYNV8rmFp2WCXHgi6cApj7wCfq/3AEQkguuOmYrEL8AiBBODo
         L8FC7/n+h9Fmz5cUbJl7OF1jVME6hGKMcdG19hxVU+Fx3Rp5BH1D7lOBKWLUIwme+6hV
         0b/eNDicFSWRWOo/vGTm87yTA3RNJ+8qJi/y8GemhpOJP7/AIK5S4wmau0StRX884RWa
         bKqEckPBv5sr2rVKTOj/NQnOlOCaXIG+zatwgsfkN3qJpTk6yPN18z3h8rS5GiJNY5f9
         ImEhmLMp0fWGZA977+EwHYnm9mdddYCcgSubGUbhUYowJ+SBkswEHS22XMuCGwDoHr5t
         7Ngw==
X-Forwarded-Encrypted: i=1; AJvYcCXXCJysuPXBkq/5Uim/4e7eY9l5NjazG51EXkYsk8R8zyAzc0jOAML6r6ctgiRIfD6ELGtiwoWYnjK2lVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM93CPjhXh4vUwWOV9eocXtIkndQeJh+/i4lPVVc8SiLoMiJlA
	UJuAj+Lmph1WKcHGwDeJBn0KRtcbaxEg9/ZdS96F/DMKNgrcVCUuRTO4
X-Gm-Gg: ASbGncvkHhMMnV71GDSKmFG8XeGFRH88dHeQsQtpa3WbUhMy+M+f5NjmdLtNwBLwd0G
	Oj1kr6fsDcxo64mJnf/jIna6zFE8v+zKXB7AcFUzR1bvBCUdctbc/wsYkm9dq44MiJXf2XourGP
	kmrtnZWQ6KiY0zRaabtDMTOOEqPVeyap2gn8xPZCuKppmOI7NmL1VT4vcbyeL2tBm8EvoSzGppt
	pF8+PiIKiNMFfw+SWJqWa60ILWK7TCN7eTbeK+x2CKe0g8BJRerp8Q36jD/l/3Wll3TLX6vhEws
	ji3BAEtxe593YohCxH9s0MnAsGvvulbkieJLEwoZqVwRoq/raGrMM+MJ/ql6odwZhPgsy9Y+WgT
	xrAwEX7E/mrlwbTWNtl0nNgWL/KMjcmIJHgID/sZfV5gFk3LaFbJwaIwc5q5S/XwD/+ctrh4uPS
	rHGQ+ZcWYQCW9X1si8nns=
X-Google-Smtp-Source: AGHT+IGVJcQ7+Hm8/Mbp21EWtJYFZbeasKoHxrkrg5KoPSIeIFN3VHq0ULl0RYiT/x4RRTtxCZVdnA==
X-Received: by 2002:a05:620a:459e:b0:8b1:ac18:acc9 with SMTP id af79cd13be357-8b22094fa87mr184006585a.32.1762296011340;
        Tue, 04 Nov 2025 14:40:11 -0800 (PST)
Received: from [10.69.71.192] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f76cde9bsm276498085a.28.2025.11.04.14.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 14:40:10 -0800 (PST)
Message-ID: <49d5cb16-7632-4b85-b638-8e8bc1c602fe@gmail.com>
Date: Tue, 4 Nov 2025 14:39:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvmet-fc: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>
References: <20251104112535.139450-1-marco.crivellari@suse.com>
 <20251104112535.139450-4-marco.crivellari@suse.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20251104112535.139450-4-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

