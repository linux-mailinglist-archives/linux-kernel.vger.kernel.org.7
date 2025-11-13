Return-Path: <linux-kernel+bounces-899263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952E5C573DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE4F3A1647
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB854340263;
	Thu, 13 Nov 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="GV07T8Mb"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52E33FE2C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033823; cv=none; b=E5SvqS5UMah2cSzBOrHRclps8H8AlhNeQgFR9TwwK4uKJ37ArfJZLpADly/r+X+5EAIy9bjKeEriuqtK5bAPQ5V/OLRxGSN5Luq3WgnsT8sHUjA/doEDN5z/wCUMrQWzYxVWVudM57AE7PcI3dzDm0BLV3tLgHgrBaHiAOXDuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033823; c=relaxed/simple;
	bh=8jU+1vZz6L5NkscxLfIh4Ckz53MdUb69WF1JC6kXM9E=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6yrUt7CjhRcjpJPWIxeskWWHMMm4bFTYruZ5B0IFdi1KuGQdQOTS59L8ay45fAa1aSRaOiaIjih7+5jxukWigfEQ8JhPTf0sliysUZdehOQc5Ys1A4uAQNMD3fpMcmS+c8aq95y5NoxndgK5F7S1ianmZquMk+qymcG9Rnlqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=GV07T8Mb; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0776740253
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1763033819;
	bh=tTwKrtkcxeUpwMZkfKhEnePnSBMcVeHgD2kHZ7V4Ido=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=GV07T8MbzsOMInsAxBFTsdgQzX4ikSfo35e/6Nu4mF8+3w8DLegQ7j+1UfV8agvsA
	 5dr40oRWZX4FE4q3cRJF9ekU9kU+p881YxKnJhQXQ20wFU/X33MLeYS14Hlya34w57
	 Buh3vezCd3l60k5MKU8skdMKGCrSs4bWTmm8Ug3BoIJ2bz96dPuknVfMA/hBJwC8Yp
	 TdC/w4eN+X2/Pewr87UhLLIunsl2ixWYJnnPu9VZowXHrbbIhVjLasOSE8Vcu5XnD5
	 oKcD9r6/pmAjNPTMnRjZfehidtljb9RByF8TFdqOHy5ndorYjHeZA69HuR6FebW/Av
	 nnYngw7ghXmMALrsTAXZ31DATID84jgOfSYZ4G9PEO1QsBv7oGrxhJygeZoDSRz79w
	 KIHjWW8DeQvqh4rjMJs1pzxRsHNmJG7n9BaXbAtK9G1QqfK4kCFUAPG51YchuV37Uc
	 YS3cSZfRPijtP2NV7zMOl22Cil/cDKiGn1KfovzQEhb6XLafyC5oJtKtvhxpT9Mr5W
	 8JSyTFNR91JqwZmmauF69BZdQZpZJ/x+TnYEXNxXjg7QXlYEHfF6y4JcphZzRtsGwF
	 VsRpfkLQgGSqD9kXZvKkgVhg2HszJTPcvF8+cFq4TGpzrFMu+jmaYFw0HbS7XJkl7p
	 Wj2JOI4kyoqzpCBOY3Ztj4ls=
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7270cab7eeso51652566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763033817; x=1763638617;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTwKrtkcxeUpwMZkfKhEnePnSBMcVeHgD2kHZ7V4Ido=;
        b=Ud9me2YK2HbeATtMVbHzMkPDf4hd6vOeTZ3xwtlXoJBEXAz4LFZl05HdGT94RlhZl4
         mT+sM9TpoOj+duo2PUFmfBmp95wvDmIuFuw3354QcbfFAoY6nYa7AYbyrrObXTQc+dWE
         OFObpuMpfm21n0yE73eYDfrKqCrNBCvFJLMhaSD+UTu2Z9AXTeY/BGg78voWehYfEnYT
         ZkLkXHnJdKM+Rn9aBNb8jyDkn4PQYefUp5MdZSxBQEJl5YM9A9ppQjIM83avIeeBeVm5
         wdsK0BuhwbHGkNFUUyk4OGnFIhH3c052TmXwtFK6+ssctjQaOFYltJkT2q5EujMZa/qx
         /3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4aLFr1ZE7hOXSUt4ccbyARYeorULMkSmekFkuMg/Ua544gyn/hmQdscyvJmmS3HbY5wcd5fMSudWLT3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0T8/a9n3D+hqf9pQf0ihsvrZQtxVsc1Z0ngoLasE17m13BL2
	Lq5IcQej1mc9i0EMbKRvRHkB65fHmnhZFcGBjTZkvE/5v13ezgJ5NN34m1UdFtDx9sYQYM2fugv
	0DDfoiAXgSgz8oQP7ts5mS9DthcN167SRhPF9xsVZBQqdD3JthcblxYOcuKUZSIlYF9fJA8iSn1
	bn+WtHhdMgLCg1X9qHYQvqYxQ1Fxtei/+C1tOJadEdI5Ye7yM8Y/gnesfJ
X-Gm-Gg: ASbGncsdbmk/+trNON0L5pHLeQxeG+BJs06vYQBNvpY35/eAGcEscizCMzdH8BXPK8U
	RfBMxSUmNIZ3qnrUcEiv2ztirBUV63GESw4taCu9anqR3nX1j6P6A4DjfIweULTjSNyqUSnaGN+
	SMb0js6Ky9wigfjDUr4+yqxGawNyu/ubPmXLI80NCRBSKjhdz5xFzx2Q==
X-Received: by 2002:a17:907:720a:b0:b73:54b8:3321 with SMTP id a640c23a62f3a-b7354b83da9mr175919666b.17.1763033817020;
        Thu, 13 Nov 2025 03:36:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH2rdITPXdMg5eNmeFWEtQ5puXeuB9CHsjZH+fXibndce/rG2EHRDWwbl7C/WqpLJAwgnsHwB3V3VYGkY6nnI=
X-Received: by 2002:a17:907:720a:b0:b73:54b8:3321 with SMTP id
 a640c23a62f3a-b7354b83da9mr175917266b.17.1763033816572; Thu, 13 Nov 2025
 03:36:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Nov 2025 03:36:55 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Nov 2025 03:36:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3951551f-02e9-41a3-8212-ac1cbaecc69a@kernel.org>
References: <20250930142212.521925-1-emil.renner.berthing@canonical.com> <3951551f-02e9-41a3-8212-ac1cbaecc69a@kernel.org>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Thu, 13 Nov 2025 03:36:55 -0800
X-Gm-Features: AWmQ_blgdQiy89oEkISH9ivslIUhSWgwxrtxxrZTErLd-hvw-g1OiCf3_NwkAG4
Message-ID: <CAJM55Z8te25nDEW9hGT9rRzSwwKzkEBJPLfCpwgMwxvUzu+5Yw@mail.gmail.com>
Subject: Re: [PATCH v1] nvmem: core: update cell->bytes after shifting bits
To: Srinivas Kandagatla <srini@kernel.org>, linux-kernel@vger.kernel.org
Cc: Samuel Holland <samuel@sholland.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Srinivas Kandagatla (2025-11-10 09:32:08)
>
>
> On 9/30/25 3:22 PM, Emil Renner Berthing wrote:
> > When support for bit offsets of more than one byte was added it
> > unfortunately left the cell->bytes value at the number of bytes read
> > including the offset. Make sure to update it to the proper number of
> > meaningful bytes in the returned data.
> Sorry somehow I missed this patch.
>
> If the number of bytes are different to the bytes that are part of cell
> then the parsing code seems to have missed some cases, which is the
> right place to fix.
>
> Can you share more details on the values that you pass as part of the
> cell definition.

Yes, the node effectively looks like this:

sid: efuse@3006000 {
        compatible = "allwinner,sun20i-d1-sid";
        reg = <0x3006000 0x1000>;
        #address-cells = <1>;
        #size-cells = <1>;

        ths_calib: ths-calib@14 {
                reg = <0x14 0x4>;
        };

        bg_trim: bg-trim@28 {
                reg = <0x28 0x4>;
                bits = <16 8>;
        };
};

/Emil

