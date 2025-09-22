Return-Path: <linux-kernel+bounces-826471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C4B8E9CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8D07ABFB5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E312B94;
	Mon, 22 Sep 2025 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsdmvbXW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDB8F40
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758499404; cv=none; b=I4v+f5SXa1rOQvTtC19dcH4k0YqEqx7OfFfYopDE5uuAmfYQeUeT4LB8VBHrV3EXlt11TT7WFwqtPzelEE0u2w0KeEMBAQb3aCIFGsFBsN6XWpXAbBs5JFaREI6LK7pxxKhzXUPv4TTn5KY9Y1w5Hiiyvdv0/NCXeDvX1Rzr3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758499404; c=relaxed/simple;
	bh=5S1RAPbr3qVsBqfhEwUmh/5GNlslYTzXJY2zUUc9kcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcfzwEA3BD4zK7R3eXvKjtfdtihtGqMBFzQ9e9oT/i2NfyoPjyRPmbu3SOpIbypaPbqW4YlFi21IgcM5BdVvILmaae9tFugGLRber0aGX0UOVECLiYIsADl/Jij6ZLvXX2QF2gxm8nGxGx+YRIe4LlpyjOB2cWJo8kzJk/1gBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsdmvbXW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758499401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDXuqYgBTFSeTj9HmL3kCs/tVEJAWswdP19jlLEVGcM=;
	b=LsdmvbXWofc6PRa7bwSzMMOOyB/NYk2S1hiedUqC2QcEOfK8P4tcutlO5AkyNtxCr2WhtW
	sHu2LERZXDpQMpQWYy7PBNe1RlXA+1vEhUZlF5WwKvXRSSxCYwd9kExk8e5FSECmkJ1UmZ
	+noeM2MXkrVIK3wiaE5pfFzN9D9JKuA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-5tlfrQZBOsm7MgmFseSYlg-1; Sun, 21 Sep 2025 20:03:19 -0400
X-MC-Unique: 5tlfrQZBOsm7MgmFseSYlg-1
X-Mimecast-MFC-AGG-ID: 5tlfrQZBOsm7MgmFseSYlg_1758499399
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2698b5fbe5bso46505525ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758499399; x=1759104199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDXuqYgBTFSeTj9HmL3kCs/tVEJAWswdP19jlLEVGcM=;
        b=RoIQMnaFXAXWmFhO4aLmUGRfKA2rB0K88v0RT36q81Ue81tlJP+uYqhhSS72auAxSn
         8oEyUyUqh1Iw+qGJ9XRNkSeos1XiGMa26xaNhQFJ3JvzzaKogFEIoAKbIO5xndH1eOqn
         /h2bQJ1KtUPawinQ8DagX6FdKGGIBpGJfR6tWSIpd2IWvnPuOYPvXT4qliu53fEbS71U
         G9VRMRGTQnF8LxgzMdMkhW2jyPtLnWmrpQZYbNwzFtYZw5zproN791fGq+fVlvBzKth9
         uzQOSK0g+BCXqZHt77ac/ZGdkiNEbzedx69rsoQWgB0QFpALKOTNab03z4HXy7EjHP5J
         4OFg==
X-Forwarded-Encrypted: i=1; AJvYcCXS4lgKFv+T6JnC0t1VmWFXDhpQP0JOg2LnZUAEE2DmMzSCWHRxtxtUhjinmc2aaU2rGMo0oTjnD6iVPvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9za11iyfJL5NaXGuqD1iahE7cE6sXtBQuZ10M+z7qhv/9did/
	5tCkQxprAu3ze7V7R0XPsKYqTNu613u1zpSrTyUfgAbcE6dT9jcZA9On836rcwvjJP4qBK1xyuX
	Hy7TinYdErmRy+SNElGenEYgWWXur1XVrfHCad5ZtfDrkjwFodY5fBITMo1RyPMKSAQ==
X-Gm-Gg: ASbGnctbHWiR26EIt+vOY1c7fOn0izwd++llfrgHEskHB6wcq+yRET8s7NNKofilaHB
	2YpaA6gFAb+hK1JbwPn7W+y0WHvS8F1tUQ1/veCbF8/fD7wsHmEB5aLws7CLF+YeZYsj8Zxc0/1
	5tL+9kkbrgvFMh9HLVPttsstMwXWRPvnB865BCURYMjFSzUxyWYKCzVBeZbyLZn8tUfmSwge5V8
	Z8IfizDG5JpO7+j1CRIOQiqz8El34QJbHyTw2jOYERT8Q0ogvh+kFCWvF0WCEINujlmeZBilxeD
	7bNiVW7mQPVajZ7Q+gsW8olZhzm4hxCrxm07D8ugz6rHF8xYeM/s52S4LL8eiRoqgiQHaouaK3e
	Ph4oj
X-Received: by 2002:a17:903:2f83:b0:265:bb0:cbc with SMTP id d9443c01a7336-269ba559260mr154624365ad.47.1758499398742;
        Sun, 21 Sep 2025 17:03:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0MfGExlYWTmOjV1WzK5kji6eVj+QSqlsV+EO7ogGlqCirbQxRS/TDHG9aRgu0NS0ideP2VQ==
X-Received: by 2002:a17:903:2f83:b0:265:bb0:cbc with SMTP id d9443c01a7336-269ba559260mr154623995ad.47.1758499398419;
        Sun, 21 Sep 2025 17:03:18 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803601e3sm114894975ad.144.2025.09.21.17.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 17:03:17 -0700 (PDT)
Message-ID: <a836c085-9bd2-4160-9bf8-81c186f7535c@redhat.com>
Date: Mon, 22 Sep 2025 10:03:07 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 31/43] arm_pmu: Provide a mechanism for disabling the
 physical IRQ
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve <vannapurve@google.com>
References: <20250820145606.180644-1-steven.price@arm.com>
 <20250820145606.180644-32-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250820145606.180644-32-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/21/25 12:55 AM, Steven Price wrote:
> Arm CCA assigns the physical PMU device to the guest running in realm
> world, however the IRQs are routed via the host. To enter a realm guest
> while a PMU IRQ is pending it is necessary to block the physical IRQ to
> prevent an immediate exit. Provide a mechanism in the PMU driver for KVM
> to control the physical IRQ.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> v3: Add a dummy function for the !CONFIG_ARM_PMU case.
> ---
>   drivers/perf/arm_pmu.c       | 15 +++++++++++++++
>   include/linux/perf/arm_pmu.h |  5 +++++
>   2 files changed, 20 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


