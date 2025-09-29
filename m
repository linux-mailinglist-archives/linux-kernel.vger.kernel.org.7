Return-Path: <linux-kernel+bounces-836245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B7FBA9162
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE143BDBD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E486302CD0;
	Mon, 29 Sep 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoJfOfi8"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734F302771
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146187; cv=none; b=lNAnSP5kUFqrYSTM41UVArNeEulk6DJytGKfosXBFzJ3AlY5jeFqDCvlHdWpKXFlwj7HmFgc61/eLbEA3r17HRhx8Ygz4Zu7UqlgpdqQ23lNURlqGfUiWfH+2q9OHbqH8kZR4S1iw72Be9KKcKhhLqCKDVuC30dn/iiJw07lcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146187; c=relaxed/simple;
	bh=v33lLHmNhHgyven3UnpSjmdXiGRlpTjR/b+1VSj7xaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlqJUMy/goJ2J2YkbgNi3WxoP897Oi4y8IZNyUJMjsRs07pNO6pCTkc2g+QmK8ufavds+hYdwlb85tg/0eV7H1x9f6Xd1zjvOZS/w6Emi57MouimQlcNtvd/hbnyFovgJ1UOexkUKTfJmErhd++uNJyuu72/YXZ5NR8HE4QI45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoJfOfi8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-634bc2d6137so5737107a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759146184; x=1759750984; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mbjVJui29v4n+pWGfvI7ZRvpZGP8q8p7zkZRQub17I=;
        b=aoJfOfi8xfPNJk0hBDIrjzDXeXowAdw5sjRFlccBeOMS6dTKvs53AMfUej8RZzFc0E
         0WNSQS0ovZ483/HZCfkiG4wP/KPs3Hl1HLF1D70JymNVEHnequtAe+l7q70nTBknn4XJ
         ivd9BAOydC7UjQRrTZU6zw7pL8REKVwj8FmKwGeoKsAf0rZXsVqL0NvAZi3jhb8aBGSd
         tF+RUbWHIFbe5kG+27TCEI7hAWipHWOT+uPcbyx1Ma9uz1JWcaB2lJFlWS7UnCpjCpvb
         CgfKrihbA8kd+UzJX1tqa+Q5iydzbN+lj3e45gz9z8M2gdoH06MsnnoplvHMlYyRc+7u
         cxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759146184; x=1759750984;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mbjVJui29v4n+pWGfvI7ZRvpZGP8q8p7zkZRQub17I=;
        b=hYOgKZ9+M1XRo3BXuWBRjaww7+nEVgEzMlFC4W/ERILKxcFp7KN4inIS+K3CqSS8T0
         3S5Ac2Gf6PFK9a0Ou8jXjswR4mNNSOxYvn/izh4tIbs8CiBIIzRoY/2q8cKu/nRsSidW
         PJ9FEoLPu7gwOjI4ns2qVc1sfT3QlWkUU9S1YdAApJhbZgADsxQq9DKg6ezJaPW8vDzI
         2AkzeveK1vxalAPFJXcPhLEQT2Uy7pRXXfa8PxFyymGmmIVVkpPQ6ZfG/BLbJYGKmGie
         nqDslewN6x/lvSB6FTN8mZvXGqr/En82cQzV+wJvNiZikM57ULvB49ruzYaobFOSzjjj
         5Nwg==
X-Forwarded-Encrypted: i=1; AJvYcCUyWh4Kg5Y2iwIO8sY3hjij3s/vSmkf02b9jjIL89w8xh5XQM58G2a1HDs3BGjXKEk1aHZOBzreamaHCsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0jQSPB2xRq0nWPIeUg0HJbtGq3CpkxZNgj3PorvpdTK18oJL
	AlIkBr485v+p9UBd3bCZTECPZ4WNV8MpHVJzfaSK+cA/5DKkLCkICRQE
X-Gm-Gg: ASbGnctXaVC0cKE/Q/Zcyszp+Iq8RpmN6/zzdY++zhYFT7y+vF+tnd0hrX7gAQ9E+WD
	WPZeL8WZDsHGtEpDmfKOHTpv05Fg+jaFaS6avRxW9UiR3L9NfBnHVlL3ipFnrI7cUoEIyxUau55
	wgeRK/IMOAWRIIxp8Si8Q+VuVOiC/zexcLALaBvotmcqZYYRlLzSeu0k6vRn+OMqFC2eUghW/yA
	Bq2pjZhyM8YCx0/kwj8UjDTWz4MucwuCIF9uxZdiI2jsYtx4Pxu1M0llwtEt1S6S5RJlzz3TQgz
	eFttajMq1ZjjIxAaxOsVhR4gdHQZ6cQO72GuuHLRZoKX/ANsNFRj7w560etLWm433KHFDww6NGg
	eTVDWTS6CNmnZ1ft9fhtFirqdTGfe+2ghya9d
X-Google-Smtp-Source: AGHT+IHpSaj2SVniGIDju9aHpbyUh48ii8/cQ5YSVvAGh2d+K7m0MNGtY13FQ+XBP5NLGndaXCuTRQ==
X-Received: by 2002:a05:6402:504b:b0:62f:cc4b:7b53 with SMTP id 4fb4d7f45d1cf-6349fa932c5mr14065525a12.37.1759146183418;
        Mon, 29 Sep 2025 04:43:03 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae3080sm7873345a12.34.2025.09.29.04.43.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Sep 2025 04:43:02 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:43:02 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: dev.jain@arm.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	baohua@kernel.org, bhe@redhat.com, chengming.zhou@linux.dev,
	chrisl@kernel.org, cl@gentwo.org, damon@lists.linux.dev,
	david@redhat.com, dvyukov@google.com, elver@google.com,
	glider@google.com, harry.yoo@oracle.com, jannh@google.com,
	jgg@ziepe.ca, jhubbard@nvidia.com, kasan-dev@googlegroups.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
	nphamcs@gmail.com, peterx@redhat.com, pfalcato@suse.de,
	rientjes@google.com, roman.gushchin@linux.dev, rppt@kernel.org,
	shikemeng@huaweicloud.com, sj@kernel.org, surenb@google.com,
	vbabka@suse.cz, xu.xin16@zte.com.cn
Subject: Re: [PATCH v2] mm: Fix some typos in mm module
Message-ID: <20250929114302.eshtdbqkjiuflsib@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <3c3f9032-18ac-4229-b010-b8b95a11d2a4@arm.com>
 <20250929002608.1633825-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929002608.1633825-1-jianyungao89@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Sep 29, 2025 at 08:26:08AM +0800, Jianyun Gao wrote:
>From: "jianyun.gao" <jianyungao89@gmail.com>
>
>Below are some typos in the code comments:
>
>  intevals ==> intervals
>  addesses ==> addresses
>  unavaliable ==> unavailable
>  facor ==> factor
>  droping ==> dropping
>  exlusive ==> exclusive
>  decription ==> description
>  confict ==> conflict
>  desriptions ==> descriptions
>  otherwize ==> otherwise
>  vlaue ==> value
>  cheching ==> checking
>  exisitng ==> existing
>  modifed ==> modified
>  differenciate ==> differentiate
>  refernece ==> reference
>  permissons ==> permissions
>  indepdenent ==> independent
>  spliting ==> splitting
>
>Just fix it.
>
>Signed-off-by: jianyun.gao <jianyungao89@gmail.com>

LGTM

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

