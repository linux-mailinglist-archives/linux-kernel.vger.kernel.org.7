Return-Path: <linux-kernel+bounces-726977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEC9B0138C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33460172478
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2498018DB2A;
	Fri, 11 Jul 2025 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qkn6uYHK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45481DDA31
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215291; cv=none; b=jXfR7FXEyPan0ZrC69HiQN0tUjnurISi6sx+X6JFTzyr0A8oB+Js43Mwm4Ut9z9zjYl/babEEn0qhkURrnqApZ09XC7ZB6T8uLuLNEO/+DsLdqcz3FZY3cZZ0SSAliOoE9fQUOBkaTrRh/tDb0IFsS9vuAKghToCAdbdMOOqS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215291; c=relaxed/simple;
	bh=7FIkSpRtIWv8965eZcis8mB/qEEeOSQHUZozxCqMG+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4S4/y5PCbyyFVT71CIZwNorLtK3aLuqWg9WSQOADj9NMiec1mgTyhXIMBpiO3Q3k4X4TI7AM22fhP/UN4dO80IIMvYGDYyL6XKgAPdApWpx5yUmRFZVlzd1+joz/rzC/pN7TOgcuxVnmCQet4cdBvL3WEOBAJXebJy+efawSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qkn6uYHK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752215288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5yuMhJDeoGODLp+FzDlwUrYAyuWSH+IuMUDEgV5S08A=;
	b=Qkn6uYHKvuBVE3/nMalcOOZyMD7MQLs5PQ2eGQa2Rsct5Nr7yr51ckvY3nVqCnTCzoCPuW
	vGfPnwD6Z9561PblR3/Mf0sauUkIm4mRRsPKmYhVuZbL74lRK9yBU9iZbuJvOobD1OuoTe
	qcGFceHjjIYDLrYAP9ZilYJk0ifLDgM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-4gLJgNItOlSfqFlq_mtYEg-1; Fri, 11 Jul 2025 02:28:07 -0400
X-MC-Unique: 4gLJgNItOlSfqFlq_mtYEg-1
X-Mimecast-MFC-AGG-ID: 4gLJgNItOlSfqFlq_mtYEg_1752215286
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453817323afso10777525e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752215286; x=1752820086;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5yuMhJDeoGODLp+FzDlwUrYAyuWSH+IuMUDEgV5S08A=;
        b=FqqqXXvDONdIWjZHaWQhwpfQ2MGdYIGOkXG3TRMxdAayAKW8b6GAM2QCL9FVyDENol
         EJUGm+TScGIri87CJ8R8TL0mGLHwFo9XC1Z34+mJ+HEvail0YPgPfQ07tf4ZH8GAsW6P
         RMNji2xUoNgkhpQbglZDMK/3um/hzpK2SedA/Eg3n1SPP5gRj9q0RPmaRpICgbQfCxUa
         mA34dihQY7g7y2gade9xir7A6xaQSg4LWPXPSPQ+TUDQd2McsrBzYvHINzgcuqhT30Di
         JRgul5qX/nKAzm/AeLtD3Nc8TbIgFUgZHm+sNTqzN2PGGcL6G49O8+obgDrlBtvh2wOK
         aS5g==
X-Gm-Message-State: AOJu0Yy9fLk0QH+2V4iEkVOMe/H06yRQdhO/G79Y4Wy25WjwIbIjWDtj
	WJDctPBSkzclI2kFnAMU9hc+/HLNU8iqQRGI4J4mj/yM1hY0D8lX7lOyRYCOj8h90wNyaHFGOAm
	7vLeeozeamZwCb/ngWEZu/0NIhfU+b2zdhm2NIUXeUzUcZ7yBwGY2yvlj6vYFMk6d7g==
X-Gm-Gg: ASbGnct6hnsOPFwrToWB/e2tpnXzMeGmZpV25hl2BY8z7SBdxyHY2xmy3w5q0rFOTGd
	1pSa3qQsYWsdaMh+Obzz6y5qPiE78fke8f/vFU+gD2iNN33HvO6RtgE/OAYU5cE7oxec/beReJb
	Tzjv82sUOUi4foL/jR++3YYhd0wAk/r9OOFr6BUYmn86sm2Xv0ZP/zN7yEO6URVdWRPBlP3Bm8c
	RX7DJKmV1fNq9RwpBFI66TDy74+Si7FxmfgNs4Q1+tMHBciNbMqv1ysDMfnXrvZVpbotnGlZaVH
	km8xxSYmmtSreoPvHsDumZQlTG6egCIN7s/eDKZwvis0OZe/iW7FBffzV3FHoAI8Y8yxnz0=
X-Received: by 2002:a05:600c:6095:b0:453:c39:d0a7 with SMTP id 5b1f17b1804b1-454ec15a9fcmr12845545e9.5.1752215285855;
        Thu, 10 Jul 2025 23:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl2Z0Y5P5d886DI1KpkHL3BZdrtkMcJVx86CIP8L6xMWunEoCVGFXwzpci6tUhbD8hG/oDkg==
X-Received: by 2002:a05:600c:6095:b0:453:c39:d0a7 with SMTP id 5b1f17b1804b1-454ec15a9fcmr12845325e9.5.1752215285381;
        Thu, 10 Jul 2025 23:28:05 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1faae.dip0.t-ipconnect.de. [79.241.250.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50516c8sm75344785e9.13.2025.07.10.23.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 23:28:04 -0700 (PDT)
Message-ID: <771f0f0d-832c-4514-b56e-064ba093c5e1@redhat.com>
Date: Fri, 11 Jul 2025 08:28:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the mm-unstable tree
To: Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250710175446.128c7def@canb.auug.org.au>
 <20250710153017.c17ca59f1df36eec90db8b54@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250710153017.c17ca59f1df36eec90db8b54@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.25 00:30, Andrew Morton wrote:
> On Thu, 10 Jul 2025 17:54:46 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
>> Hi all,
>>
>> After merging the mm-unstable tree, today's linux-next build (htmldocs)
>> produced this warning:
>>

Hi,

>> mm/migrate.c:215: warning: Function parameter or struct member 'dst' not described in 'migrate_movable_ops_page'
>> mm/migrate.c:215: warning: Function parameter or struct member 'src' not described in 'migrate_movable_ops_page'
>> mm/migrate.c:215: warning: Function parameter or struct member 'mode' not described in 'migrate_movable_ops_page'
>> mm/migrate.c:215: warning: Excess function parameter 'page' description in 'migrate_movable_ops_page'
>>
>> Introduced by commit
>>
>>    d5967fb0bf8e ("mm/migrate: factor out movable_ops page handling into migrate_movable_ops_page()")
> 

Thanks Andrew for taking care of this, was out the last two days.

> How about this?
> 
> --- a/mm/migrate.c~mm-migrate-factor-out-movable_ops-page-handling-into-migrate_movable_ops_page-fix
> +++ a/mm/migrate.c
> @@ -161,7 +161,9 @@ static void putback_movable_ops_page(str
>   
>   /**
>    * migrate_movable_ops_page - migrate an isolated movable_ops page
> - * @page: The isolated page.
> + * @dst: The destination page.
> + * @src: The source page.
> + * @mode: The migration mode.


LGTM, thanks!


-- 
Cheers,

David / dhildenb


