Return-Path: <linux-kernel+bounces-747974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3482B13AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDAB1894D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A00266B64;
	Mon, 28 Jul 2025 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gY7Dya2w"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6C265298
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707607; cv=none; b=Ek2IiByKdlH3CM7k/AkY+ca6YCI+GUJeIUfzHXUcpvpOGLoOiNa+wF8F1Sc0Eu5A/MDeF/4hjk9bsZ30OOiWQzeOsdZZ+Zdjh4Har1Lmeh+Blxw00zgldq6YBB+Cd2w5oU9tWRrOmmU79uQhglye8m1F3Cmy9mQ4O2slIiyKvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707607; c=relaxed/simple;
	bh=iU/D2uJWHxf+NFTb9/NsPyxL1uXiaxkakw1j4LF9K7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/Zhp9KJVOu49CytS+zETe7VhUnMXOS1swkp8HvmqRrb0g+/Rn5N5jqMmXXKOuCQd43EuG68xI1AT0AgYoy8FqDb9BQZaBNoby5yekwYdSvckihH3Zjky2da6Lll6Yy1HoMjgj69opjYIInF12C7r3YNJMfRouYFULoGrrrFpf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gY7Dya2w; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so7476565a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753707603; x=1754312403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAfBInPf+dLoIc4ffodTH85AzDFQgemf1hBeYDDssNM=;
        b=gY7Dya2wVeCjFm7NWRuhMSxnTB97hs29M9/j03jfzuXnQoh8yo+ZWT6B05oD/l+NOO
         nrbiDrEUGn9vE/GjYopIDNOSUkdenlmEaq69LYu1jo0uh7gXBpMLCmpeEbSmFZh+FBxT
         CxbbJzyfcx5CEJRVeKbSn4RTmje1bs/j2KMQg/xnQrzn9JfHUHgRusPH8LnunK4xYlmY
         pbK7+L8XtSZT21wqkhPKFaV8pUYo51/12CamO5YbOp1pIey6An02MIiVngJPnR8uf5TS
         X62UwxC2AzV6SLF9ZFFz0W4lUCg7ospDenr1pftab73H/5qFJMOvr0CIbQOGSa25Kpil
         3gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753707603; x=1754312403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAfBInPf+dLoIc4ffodTH85AzDFQgemf1hBeYDDssNM=;
        b=AXwq+i4r5gZm2iWQFkcB9Bocc+NR9K0+9F51zKqRpQ10hKCX6kMOBLkkLY5lutyYHz
         OJMQSuipUf/YIYomiP0mW7i+0YmkRkh4OsKsfwI2ervM6jwd2W0H4WDqij5qDqpy0VMx
         vCReWUxcLI/PZzhKoaiErJgYRJEtcEhznmXrOUo/pfWGYCW6kDECrACQkDGM2k5aiSB9
         TMTQiHHkDGOPUVLXNtNjjVdzztT6UdGHyywbrO46ELtNb9WNE6ZDj2IC1OW8KUrF+IG8
         GNWA2+dKLpYEDbBOBMwYt/JCIxoHBvn0mVm5FHRVqe4M05KPmwX9Nmx1K3bE+nJMbawj
         +eJg==
X-Forwarded-Encrypted: i=1; AJvYcCXr9K4fsU/PLZbp14BxbG2lLlbgxF9drrwE9qc+bAYHFu2jSHa2gyrG+kc3wFoGq5cWlzkTeZvapnOTEug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrfwC9s3MsNpd8zvWVDop3GveQx+OprvbuivI02dTit2rumuH8
	LQbjeZaJ6Qidd9mpTXAQOwucz29AAxsFJ6YLE8BacDLmmaOon39N8YCsDRuQf554o5g=
X-Gm-Gg: ASbGncuSSDHx1TZU6/VnPzBAdp7wLq74IXU5nNlaOKD/XcbkDYymA8Uet4nvmDwi/gE
	X16sYB7DSC3rCvkFfPISrL+HtIqSWyvFr0SklYYKwtvtkgGhQAJYQczypxT5i5fJxQjJNiTviN2
	jIDvshS2BY94HQjQ7puVlLqnPHWxPaDqBqPmsUvfn4jm/DcFkXCMAYWgFyKwVuqR3ODSI28bjRE
	nHOZ7GPq5bjW0K0sWitpwFraLhPP3IUqhX3CL22OBxY/TX9S8jzWT4/MZlFfyUmEUVrY5jYqLNx
	TW7haGmab9AkK/wOCxouPTmnGHWswWlxbl19+fjllsakbmPykUq7AHtx8QhsudttYBSHvMPHgng
	j3gzRoYaiCt2nurZU/eyIqlfZ2KWhDVlFRnc=
X-Google-Smtp-Source: AGHT+IG5X28gD574aSfiw70punneJAnRvXl60rca6iHDYvwTxnKefPuCmX5/hlF8rd3WQn9WQZZ/tg==
X-Received: by 2002:a17:907:1c1f:b0:ae6:e1ba:30a with SMTP id a640c23a62f3a-af619f01c1emr1288654666b.54.1753707603345;
        Mon, 28 Jul 2025 06:00:03 -0700 (PDT)
Received: from localhost (109-81-20-172.rct.o2.cz. [109.81.20.172])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af6358a1aa1sm411374466b.36.2025.07.28.06.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 06:00:02 -0700 (PDT)
Date: Mon, 28 Jul 2025 15:00:02 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
Message-ID: <aId0UlyH9ErtGDl2@tiehlicka>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <aIdqVNCY-XMNICng@tiehlicka>
 <1f8d924d-3554-43a6-a75e-66a08d1ce7b9@redhat.com>
 <a06922c2-9dad-4449-991c-913fa7765bc2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06922c2-9dad-4449-991c-913fa7765bc2@redhat.com>

On Mon 28-07-25 14:27:29, David Hildenbrand wrote:
[...]
> > I think the whole libdaxctl handling for onlining memory is based on that.
> > 
> 
> Sorry, forgot to add a pointer:
> 
> https://github.com/pmem/ndctl/blob/main/daxctl/lib/libdaxctl.c

Thanks for the pointer! I will have a look.
-- 
Michal Hocko
SUSE Labs

