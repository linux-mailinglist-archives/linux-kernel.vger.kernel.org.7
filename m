Return-Path: <linux-kernel+bounces-721111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11314AFC4E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329A73A8981
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B491C29B22F;
	Tue,  8 Jul 2025 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TjDeHbic"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243A29B8D8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961616; cv=none; b=o/VfzxsTL8ZC6hTRplnbEsDQBKyiMQT+KVFU4P0rt1lHCZ2ja212xsYyX4og1qOeUag7d35NxyE4qtkOyFAH8T/bx5t38FLg7uPh6/evBM1/9x6eCrMPkj1TeOX+fZYBUrxcx27O/3J59gxJ9URbwQUqucNw4f13tOfCQl3zdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961616; c=relaxed/simple;
	bh=KsRvc36WADMEMBlhmFW+osm7axtgpd4Z1XQCHNoNoQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPcX31vrTG/17sLJv8kSvIIDjRBDEHqr8Gp7G6r6jiNDFQaIcKI40SQ/cI3M8lSmI74Tvyk4FnALZnJ6LN24H5N0M8QgbXQmB8WIPdGBo/P87BwCKcy/rtrFNY2+hh6WIkhaYeSKXfvD1zx2i/LIpPY7z7+uAD+Qrf9YUuZCfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TjDeHbic; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso34475945e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751961612; x=1752566412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZdPyCm2AWDYlZEaXQWX2xUKH1HJ494dTDfBl58uctr0=;
        b=TjDeHbicp9aCW47AevAgHOmk2BfzVrRTepmur8vWx3lfn0b4ickkkgPoJFeSfiK8fZ
         0b2ujv5rJWa4CUGzvpD6rFeERYasdTqCGQLgcZFnDwd25UtYWoGvNg80uW/A2svU7q2K
         R4acxSti82HR5uwT8vACQO92gEFGiOimCXZ5YSvqPcG97EcBpHDrZWIsZ9fENfkdMU0w
         rGUgM+ufGi6ELzd0wrEdxLiUHp5QXNygY2yGWlocDJQxSbB/NC9gkBR59XN1z+9VnVji
         crBeFrcIZXADIlX8xylawdFRp5GH/4LGXodkBnW4ob+uT2LIne72TFPrgrCJzeFl72l+
         M66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751961612; x=1752566412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdPyCm2AWDYlZEaXQWX2xUKH1HJ494dTDfBl58uctr0=;
        b=hn1PNx357319DKUls/J21jVL6ZFinPUNpdxopEwtQw3rvzoKsux2T8FhOYSZgMXiIl
         SdBzTP2+JS56Rzkl+4qPZsBqfvgklDHEfLpKdBD2VXAxVmvafKd7SnFjXIt+4FGApxc7
         Qtuxc9RyFXs9p8DaM8vniGmJamTK9OaEp64r2HZqCfL4i0aPNxgXZJqZAks85dFbIMZP
         SV8uxjP1jWw2q3KCCFOAV7R4BDKN9slqH07S47nGisk4nbn7LEL0PK/VpcQGSarRDWki
         MZzW2uMH2/TSAfl7o7lk17I6tMTopzLwaMksdxGIJWd/b1/+Q0EAhWiljMT9tESiXK2w
         vtYw==
X-Forwarded-Encrypted: i=1; AJvYcCXpnW6CmkGts+it9wz01GfFu41DGtx7E5CKRIfwpYoqeMnH3n4ITJPyhjICx/ngupAEb3Un1/vZi/2n/Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysT1R3PYMItUOiTgvKT58Zau1tmNAwx1Tr6cSwBenAp56a3TWx
	+vBJ7MD6QdA2RGdej+kn4JfNDcVOWU3s5PrdJSBBDuLU2l9vGKmbPUYWVi5Th3fKY4A=
X-Gm-Gg: ASbGncu8p8y4kM2XZ/HN6UviRSaFi2FcN1jJniF0wzTj/o1QuTbPvImDIKHDXz6p0X+
	yQfuZYDhFL8m50JS/nSQbLVUIfpUNId9Z6rs4GOmZAUHS9jMntX0qCeGq8DoeNAjsEcXfo0Weam
	AMX0UsnuSQTl0WK0e0aTt+K4lSqAXAonP4X8IvYY5z5vsrbdlPEP+g/mre4LMo8dpyLTnUiX/QV
	1xamucqQJ7iqpAN8zfMnF711LtIg3PGu41mKuHo7w/B/K2/ghzAUXPndUV52k26SDG0seGA3OCw
	haIAT/jdjLI4ckR3vvz+yaGM2xxRkHqCxL5Szc9xSLVzi4NIG8KD9F1B/+gybsPGng==
X-Google-Smtp-Source: AGHT+IEsA/z0OzbHwBngjkFHy4ad7foMqG15RG4ohIVwHNUpcdFHggy+ThQVZ9RoheLwCsuwoPnrdw==
X-Received: by 2002:a05:600c:4686:b0:442:f12f:bd9f with SMTP id 5b1f17b1804b1-454b4eb82f0mr147958165e9.27.1751961612040;
        Tue, 08 Jul 2025 01:00:12 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285d3c6sm12359083f8f.95.2025.07.08.01.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 01:00:11 -0700 (PDT)
Message-ID: <15ed6295-87bb-430f-98ef-b856752c23d0@suse.com>
Date: Tue, 8 Jul 2025 10:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update Daniel Gomez's role and email address
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.com>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>
References: <20250704-add-dagomez-maintainer-v1-1-5fc32033c51c@samsung.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250704-add-dagomez-maintainer-v1-1-5fc32033c51c@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 9:39 PM, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> Update Daniel Gomez's modules reviewer role to maintainer. This is
> according to the plan [1][2] of scaling with more reviewers for modules
> (for the incoming Rust support [3]) and rotate [4] every 6 months.
> 
> [1] Link:
> https://lore.kernel.org/linux-modules/
> ZsPANzx4-5DrOl5m@bombadil.infradead.org
> 
> https://lore.kernel.org/linux-modules/
> a3701a9a-5b42-4581-a150-67d84601061c@suse.com
> 
> [2] Link:
> https://lore.kernel.org/linux-modules/
> 458901be-1da8-4987-9c72-5aa3da6db15e@suse.com
> 
> [3] Link:
> https://lore.kernel.org/linux-modules/
> 20250702-module-params-v3-v14-0-5b1cc32311af@kernel.org
> 
> [4] Link:
> https://lore.kernel.org/linux-modules/
> Z3gDAnPlA3SZEbgl@bombadil.infradead.org
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

Nits: Link tags should be single lines and their indices at the end of
the tag, see Documentation/process/5.Posting.rst, section "Patch
formatting and changelogs". The second link would also be better if it
pointed to the initial email in the thread.

"""
Update Daniel Gomez's modules reviewer role to maintainer. This is
according to the plan [1][2][3] of scaling with more reviewers for modules
(for the incoming Rust support [4]) and rotate [5] every 6 months.

Link: https://lore.kernel.org/linux-modules/ZsPANzx4-5DrOl5m@bombadil.infradead.org [1]
Link: https://lore.kernel.org/linux-modules/20240821174021.2371547-1-mcgrof@kernel.org [2]
Link: https://lore.kernel.org/linux-modules/458901be-1da8-4987-9c72-5aa3da6db15e@suse.com [3]
Link: https://lore.kernel.org/linux-modules/20250702-module-params-v3-v14-0-5b1cc32311af@kernel.org [4]
Link: https://lore.kernel.org/linux-modules/Z3gDAnPlA3SZEbgl@bombadil.infradead.org [5]
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
"""

You can update the patch on modules-next, no need to resend.

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks
Petr

