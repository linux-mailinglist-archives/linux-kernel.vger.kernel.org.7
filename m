Return-Path: <linux-kernel+bounces-809198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845EBB509EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344254E787B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413F1136347;
	Wed, 10 Sep 2025 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bZ+cfOkj"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667CEEC3;
	Wed, 10 Sep 2025 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464400; cv=none; b=XxqYeah2GacukuLI4981m4OLG/DZTkNApWAtkw6ba58kvATTVDHPGDZSxn9NDGSziIfM9eSY9PVWj8d1tO3yKktR75QZlXUbY65w4mbu4cJRHMjrlrNWZjDDI/2LgSwYs6KGOoKFbjE0NkCFqgTNtTR497qaNt1tFXE9FiydbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464400; c=relaxed/simple;
	bh=pS3b56oiokeq0CgPfc52tIPnSWTbKs4vOS3a+kmw7jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/f8mOwbZp0O2JadP+f7n0CNhNFfOHnTkZiaNM5HXC3dA8rMGLRMyS1SH0Yg7csk/p/ENF7eZx9IvMI37GHw2zD+cOQjeUed+Cat7sCUcSZX4ISDrU4Cusr4ltPfBO2TqU+HXuq2+hugFm0/F2CQPkJykrNjj+DBlMW1JzdppXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bZ+cfOkj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+7i6AL/giGG8sDoDggEW2tn65nUMUUOKofKssaLcy1w=; b=bZ+cfOkjVovEqOsNsAmbzO+jK3
	ZC+G754RaEYlFk7SYJTZu4IivuxnzmWpDq92c8U8z9pZT/sQOKtfHTlKqbSqt0HCu+b0VSx4WKc2x
	+bVpliaDB4NlawCwjgjl0bDWflR0IoIHGYPD0Qnf7EogwXtQx3zSpeow6CebBT5SkF8jfxtqLX8Bz
	ghXIvhvFmKBUDO5NX5OzFEQr0TMfd2KFwTD7iZ3oCPmDudEZyCf+zxHDMeWqNMkf+he5zk51h+eN3
	e+ODD2EaYuKh2EGsIG1BeqOAExdofpHYTBkhvDSasvKMu0BqJovXiJwl5GEdF47eUeq2WNnBSDlYs
	+DRsEQNg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw8lw-0000000BBNh-38jX;
	Wed, 10 Sep 2025 00:33:16 +0000
Message-ID: <1c79b3c7-5847-4960-9454-0c70d02a6441@infradead.org>
Date: Tue, 9 Sep 2025 17:33:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] kstate, test: add test module for testing kstate
 subsystem.
To: Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
 James Gowans <jgowans@amazon.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He
 <bhe@redhat.com>, kexec@lists.infradead.org,
 Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Rientjes <rientjes@google.com>, Pratyush Yadav <pratyush@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Chris Li <chrisl@kernel.org>, Ashish.Kalra@amd.com,
 William Tu <witu@nvidia.com>, David Matlack <dmatlack@google.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-6-arbn@yandex-team.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250909201446.13138-6-arbn@yandex-team.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/25 1:14 PM, Andrey Ryabinin wrote:
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index b6ea861006bf..af9a25bdcd6e 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -69,6 +69,14 @@ config KSTATE
>  	  state, save it into the memory and restore the state after kexec
>  	  in new kernel.
>  
> +config KSTATE_TEST
> +	bool "KSTATE test code"
> +	help
> +	  Build a simple test/playground code that is useful for kstate

	  Build simple

> +	  subsystem development. It contains some structure with different

	                                          structures
?

> +	  kind of data which migrated across kexec to the new kernel

	  kinds        which are migrated

> +	  using KSTATE.
> +

-- 
~Randy


