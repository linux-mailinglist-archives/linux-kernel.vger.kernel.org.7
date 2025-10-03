Return-Path: <linux-kernel+bounces-841722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA39BB80DD
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE5C1B2071E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31B5220F2D;
	Fri,  3 Oct 2025 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SvUjsHQe"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8598235BE2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522506; cv=none; b=BAKthKwR7K5pdOKunjswa3wdzjgplRqj5gw+l8UZsL0YzxVcLgNZ0J56RAsehxdpueBvnryDDBIu2+QlUpT8xppioyIpaNfTekI+JexSTy/qfD50ahmLxru9b5As8EW9losKeYyZccbt816Bv5HD9nQp//B0IKNQLlKcGRPejkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522506; c=relaxed/simple;
	bh=T42UKPLSZnmaWVPf7AXUcHeWnf+mYMHeRoJfaD3CuTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpUrxXfWcg8KPdDswjfgrqRK1NykQ8dLBsmPuD5nrfpMxp6+W1Kkjw52AUr7IKD8TC9Xv/VjknIbFi2tlo0UlIEbGJuXDVUG0Kx3gFDj0OO9nzn04Knb2LziOic1uoR2kbr6PwpA3vqKd/QwXkRfyvqqPRE6V3Mf9KZb7QD/ePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SvUjsHQe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3e25a4bfd5so530496166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759522502; x=1760127302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=usMIQoc5P7F65ALWa34YUskzxYWUto/+M4S3Ej7x2uU=;
        b=SvUjsHQemJu3Pde+j24QqLo00BCYEVpf1wLSHS1KYfkXO68JF48XS2/1MXSAVewf5h
         zS+Yl77clV/9FsijaDUCZD4N7ZdNU1d26vHnSUxeqkBxnV1+5ySoh+vZ3kcKieRm68o+
         Pienkk0Q8aKncZRif7nVMlSWgcYIfjrjEpN5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759522502; x=1760127302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usMIQoc5P7F65ALWa34YUskzxYWUto/+M4S3Ej7x2uU=;
        b=Qd0MV40Q0KhylJ2myxeGiW1Ds0NB5tfOpflytEqIv0K9+PK43ZnZzmC5aZnXeHwgwh
         ZpbrwDxAi4kBbkPtrb3yn/22Qu2KSpubGJgEPEcesEFMh6ccJMLdh5Fs5LVTOuir0DL0
         16IVWFecq/rGg1aSJ7K5D2cLfMBj0y2rUPDh2hi8vnvJmTqbBecGFUmnFdpwHYIfCYG9
         bgD4hVuc+vtn6jd5XfTVmpL0eDeE3lmP4E533Oa3fQPKupPwM6ezAtRNM+oSdwUNa3gl
         p6wILgNwA4NtoI4lgapDDvGdKi94cojd4ZJQJH4jOj9BDBjpKWTOb86zHmuKIctZnbO/
         MKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmSRFul5GpTK7/kxBj9jPM3O1TTYnT2afEfR3vBNAuqK89/KzsSFL5WdSCd1K+xgczvSYlOJznaDYygmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV4MgdZ61P+u+vMbwyhD9/nPqJ0gPEQKYIREjuD2d6AFg3txnq
	Jksq9fYnnNWt59nMHCr/kNs0mNgb8tUgAIoJR2Y84cUf9JyLU3cgQIaq+lYMwdBdCSLRqNXOPcc
	+Oh5Z1LM=
X-Gm-Gg: ASbGncvHiUN68e/qTWsYK9uTSNQnw5/xVeHrM8z+EioLg+kq456a8vL9Z4a/sbKorpe
	hevQJG0tNCASASQmwz2p9IHfXMMQ0GuVIEAykJ+aJrxD3S+UGPdWLcjSnrVP4bSl7ndbefisLow
	PNtam55A03Rl6qhDJA1DgtEKdsh4lsXwAxkZ2KoJPuHExXRyjvKyU8L06imtEPxR2tWFx7cq++b
	BQrW8ZHCzZYPSoqTJrY7Ue6AL52TMOb2y88WKAQERx57JYJUxcnVWwsFlYFoWBfdm8mcuhlTAPR
	EDK1W3bVieeSCCEsl0i5Rut826h8xloXg+aLcSVtblYCDg/VabMFydB90L5vxEL3EdW0xtHSpWu
	AUKW+6IxyEWO5leLb906119/LiHHQ7ot/2G/e7HQMSufNWt0+Y9YRP++SJOAoXlGtzGEVytYSmb
	20Xm6V/3pYRf/gxlTcPXZQ
X-Google-Smtp-Source: AGHT+IGpwXXWkPsPQ3dWuHYnvIFiPnJViDRNMdkNtOQDrwjo25izwxIp83WK3Jxp7OuBJzgtDFQy2Q==
X-Received: by 2002:a17:906:6a25:b0:b3e:c7d5:4cc2 with SMTP id a640c23a62f3a-b49c39360f6mr516065566b.38.1759522501977;
        Fri, 03 Oct 2025 13:15:01 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4e49esm510235766b.72.2025.10.03.13.15.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 13:15:01 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b256c8ca246so575349366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:15:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5yhBS0ZsejQP+pDMKmxDlFAq/N/+pZbRE7oNIEeTD1WRROf/f5SLYS+81NUZJV9g1kVRm9zC9ZqekFs4=@vger.kernel.org
X-Received: by 2002:a17:907:3e11:b0:b3b:b839:577b with SMTP id
 a640c23a62f3a-b49c1275c57mr540938466b.12.1759522500781; Fri, 03 Oct 2025
 13:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jz1fvtrb.fsf@kernel.org>
In-Reply-To: <87jz1fvtrb.fsf@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Oct 2025 13:14:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfSXOgEGGt==2GjkaK-4-cmNcN0AqMEYcYfhEOa9hwXg@mail.gmail.com>
X-Gm-Features: AS18NWCJ2rnFSktdBROLs6LPL_qxBYCGu-TY5-b4RbwMELymL55s81IUidxobIs
Message-ID: <CAHk-=wjfSXOgEGGt==2GjkaK-4-cmNcN0AqMEYcYfhEOa9hwXg@mail.gmail.com>
Subject: Re: [GIT PULL] configfs for v6.18
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 02:47, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>   ssh://kernel/pub/scm/linux/kernel/git/a.hindborg/linux tags/configfs-for-v6.18

Please fix your setup to actually generate valid pull requests. That
"kernel" is not a valid address.

Yes, I understood what it meant, and I pulled this, but...

            Linus

