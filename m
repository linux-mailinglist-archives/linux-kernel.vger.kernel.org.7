Return-Path: <linux-kernel+bounces-891037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A441C41AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C034F84C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E3261B9B;
	Fri,  7 Nov 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fGUfa0xH"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA042192EE;
	Fri,  7 Nov 2025 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549458; cv=none; b=T1rvXS4Axf/hZIELRwKsAbrPmjV05F7N6/yCRcMX6g7Spu7TWKxvh6xPuZGRU2585mK5CWwXiLgObpGQwjA8MfHoJF+kpDlgaDArgafLDPCLtjqoh6DqE1XCIcNFean6qFe06eNg7xhLKPdE/ZV3Cy5D9ZBcy3KPaLtiMfWkXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549458; c=relaxed/simple;
	bh=hulFR/wfHQsXHq6CbTv9sLqKTNZSwjtk8LlSyJoOR1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YeSoHi6yP4Bi015CD2B/FNkJqoohaYNUhcFU8NVtLflVmE0eOnbB/Vh8HZvIN+HkRSl7JRKomUEkuqtwm5wkMDYSWKOq0crbGcMdaiT1ma3t3h6pLCAyYjsmZKeC6IOjsfUkctjJUTP93cWBpDsV1pRxatamj14Wwa3vMt6k3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fGUfa0xH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IFphuwdJYAwoFSKk7Q8HmR3Cwo+6wVH8aALTdLHvqrM=; b=fGUfa0xH88pMz7s5W8n0WS/oko
	vaQ7wJ+MnQ5uAwNozCHk571ULFNMrS6ofWBzhHXKl3aeIu7uzHhZT4SQQK8+SlzeA6/NJIK0qM9Yf
	AD0J03nzFPLBm8VyG5ZeJ8KSpbRRTge1EufP9Xmx+fYvZw8Ch516AV297PL37uoXP6nFPh+dnWTyr
	5Rak+0HRMQVuhmtBb9dQWv8U34roq9fgkKvp4f7a0GwkeUaGe/8Otb8FUSCtfuvkfdQjmRgu5dcny
	SjWXPZXENwyvj+CpAFnZky4pKPqewL4seZ6qY0jbzUkVrdqFFMTDoTgVoRI/JzRAwhPPhsL+PW9Lx
	kYruC1zg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHTd0-000000014n9-1ncB;
	Fri, 07 Nov 2025 21:04:14 +0000
Message-ID: <9d709020-03fe-467c-be7f-d5ee251bb79a@infradead.org>
Date: Fri, 7 Nov 2025 13:04:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs: doc-guide: parse-headers.rst update its
 documentation
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
 Federico Vaga <federico.vaga@vaga.pv.it>, Yanteng Si <si.yanteng@linux.dev>,
 linux-kernel@vger.kernel.org
References: <2ae06f370724bfd8210892ef3062cb349ed518f2.1762512037.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2ae06f370724bfd8210892ef3062cb349ed518f2.1762512037.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/25 2:40 AM, Mauro Carvalho Chehab wrote:
> -It is capable of identifying defines, functions, structs, typedefs,
> -enums and enum symbols and create cross-references for all of them.
> -It is also capable of distinguish #define used for specifying a Linux
> -ioctl.
> +The output is written at the (``FILE_OUT``).

You consistently use ``FILE_IN`` and almost consistently use ``FILE_OUT``
except above, where parentheses are added. Please drop them.

> -The EXCEPTIONS_FILE contain two types of statements: \ **ignore**\  or \ **replace**\ .
> +The ``FILE_RULES`` may contain contain three types of statements:
> +**ignore**, **replace** and **namespace**.


Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy

