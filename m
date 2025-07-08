Return-Path: <linux-kernel+bounces-722542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C708AFDBDE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AE21C245C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3B8236A79;
	Tue,  8 Jul 2025 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqMsairC"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DC1FF1A1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 23:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752017482; cv=none; b=PVn97NeOm0G6x+qCcDFur424vT4XlrHHRZBH2pGRww9GkKsrg3IEJKFFQCfexztTiXN/Uz5OpsRRDtzX+LD4gSbSJIIYuguZJoHufL6f+FL/gQ+K/fyn2WVuTF/K81vxnIcgXVWr5YUfQ9V4FzFnlmz0KvaDuusVu/XyVH7hAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752017482; c=relaxed/simple;
	bh=SAzgLu+LEH3tK9/dGy5esJYRTisM3OaXVWh7G6Cr8f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9lva87hj1HwKq+Rq2Wz6tXp1cQeXjIDox0QP8U3USHmUxmiULGgcTV5eeppmeVH2cnt57xIOJ+Vh7pZCNoAiZMruvJRGjFdM4DntY7Uk3Jhmz+cEZtrnIRapdk3u5iTe61cWTsuAv0wKPrYb/GiyaZZSeaxYQgrxTPGG2zTVVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqMsairC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2357c61cda7so38055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 16:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752017480; x=1752622280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAzgLu+LEH3tK9/dGy5esJYRTisM3OaXVWh7G6Cr8f8=;
        b=aqMsairCGVwgchMbqIlYEkhNczRsYtbtoj401ou8nnM/D4CqRgn2JZJDcfPze+uTd2
         ulwiDHRorMmYNFg3s2/NeHx4j3kpppLEXoL9O+9CbO2Qd8m+wZHKKfC/v/ntxF7dXgO5
         +xy4HQ4bYIAUaAy5WRHY4nNOn/EXWFR0ZccT7hQv7BB0bHI2ueFg6piKK4Wf2foJfGdD
         ijkQPXMwYTze6n/W2AtsmDXC1+vhvOOWf0vxNd0u45YjbP9Duy7UWnBWmwo9IhbUkgoz
         aYe2pR0MQx9huf+KpCDxoBezHDgbvQE1hzX6TCYjGd+lP2fdCJHAmHWtLt3AYFLFgKGk
         w2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752017480; x=1752622280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAzgLu+LEH3tK9/dGy5esJYRTisM3OaXVWh7G6Cr8f8=;
        b=sb7QxrON05B3ZgqZpmaaAQrpFws1+F5C4UkciXXpl/ErHMzMkBNw7+kI0u1p/XUe1r
         cSe7XrXpr24DVYRyBmTOZM5EhQFo9JIr/PNWy0q0g+QaFA1kSoE5GbwNV0uaGwFJY8++
         lIETRS8oWxECO5UfE/6XHKJuIulURtiKJz5YPkxDLiy4EMJ60u9VYtftPKh6Nr/DHMCn
         DSYqZ+5jGMaoq0BoJwM68fQ8wdDhpSLmqtDn62nlR0ow7rxUemHT0Wwc4XEkPmzbGuxs
         xboV/JrLfqwsDbcPc9A7YyzsCe2yXiW/AWuFgHanVTC489hQ8zTdT6shqqeCpznxWKHa
         fCBg==
X-Forwarded-Encrypted: i=1; AJvYcCVge4ksyYoh0R4mMgLSLwXCUGzF8fDcdQuqsdCE3dLjv83QrwLOq7RPxCqTJOxkGl6uqGa6xktF5VVULfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZCs1kyWkwi2kubHPd3C30VQsrQ0XlnjvlOy0OB33I/cf/O5z8
	nQvWgG8ltTTLaCLbKJJoGtK9+oz0ZcywW6CnRckTBR7t7ihb1io+yaYJRlGnIO4fK84sZEqqsIV
	X587uGEF4JmaEVOQeB4Q9SO0ubflo1H5EtG0qfLNZ
X-Gm-Gg: ASbGncv7d+LuwkcJPOJJWjVH+Qu2/Ltunz5kcznsUemfn/O40ha4c7/P51a0VwXfZkQ
	9N8gLqTzxjeWc51jdfF9kvHu4L/C3pmyGZ93PHB35f5E8GrGV4mQ9uaU8hSBWaeEaNl45bkgFhu
	vqeY21T+HY1v7fQ4ZEHJMmJWfliQjsPaGIL46dwWOKlBS//UZ6EJGQvec5OfvERdLSvllxU7c2T
	w==
X-Google-Smtp-Source: AGHT+IEeUeefQsUt6efuPNnMZbVeMJ+9APYmZ1n6v6/pDJBdaauZi8BF+ZvGtY7BTmSSWXXn4mHbe2LPnzqYn6deI/E=
X-Received: by 2002:a17:902:ecc7:b0:234:1073:5b85 with SMTP id
 d9443c01a7336-23ddadba79amr606065ad.1.1752017479673; Tue, 08 Jul 2025
 16:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424030033.32635-1-yan.y.zhao@intel.com> <20250424030428.32687-1-yan.y.zhao@intel.com>
 <aGzbWhEPhL/NjyQW@yzhao56-desk.sh.intel.com> <9259fbcd6db7853d8bf3e1e0b70efdbb8ce258f8.camel@intel.com>
 <CAGtprH8jTnuHtx1cMOT541r3igNA6=LbguXeJJOzzChYU_099Q@mail.gmail.com>
 <c22f5684460f4e6a0adac3ff11f15b840b451d84.camel@intel.com>
 <CAGtprH_tgn1Xn-OGAGG_3b2chOZBkd4oO9oxjH5ZMF7w_kV=8Q@mail.gmail.com> <edc5efcab4452d3b0ab6c5099f6ced644deb7a6e.camel@intel.com>
In-Reply-To: <edc5efcab4452d3b0ab6c5099f6ced644deb7a6e.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 8 Jul 2025 16:31:07 -0700
X-Gm-Features: Ac12FXy5PxCoIO6caDTH1-T1FcwjbP8ghhGzV3nVDlOeYn-4MwQVAYV2NwF0jQA
Message-ID: <CAGtprH__25vVq4XgNuO-igsamN=zgFyv8=YdUKKXap3zHCuESw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/21] x86/virt/tdx: Enhance tdh_mem_page_aug() to
 support huge pages
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"david@redhat.com" <david@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"tabba@google.com" <tabba@google.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>, "Du, Fan" <fan.du@intel.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "seanjc@google.com" <seanjc@google.com>, 
	"Peng, Chao P" <chao.p.peng@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"jroedel@suse.de" <jroedel@suse.de>, "Miao, Jun" <jun.miao@intel.com>, 
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:16=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2025-07-08 at 15:06 -0700, Vishal Annapurve wrote:
> > > > My vote would be to prefer using "hpa" and not rely on folio/page
> > > > structs for guest_memfd allocated memory wherever possible.
> > >
> > > Is this because you want to enable struct page-less gmemfd in the fut=
ure?
> >
> > Yes. That's the only reason.
>
> I don't think we should change just this field of this seamcall wrapper f=
rom the
> current pattern for that reason. When this stuff comes along it will be j=
ust
> about as easy to change it with the rest. Then in the meantime it doesn't=
 look
> asymmetric.
>
> In general, I (again) think that we should not focus on accommodating fut=
ure
> stuff unless there is an ABI touch point. This is to ultimately speed ena=
bling
> of the entire stack.
>
> It is definitely not to make it harder to implement TDX support for pfn b=
ased
> gmem in the future. Rather to make it possible. As in, if nothing is upst=
ream
> because we are endlessly debating how it all fits together at once, then =
it
> won't be possible to enhance it further.

I agree and if we can't do without page struct for now that's fine. My
response was just to favor pfn/hpa over "page struct" if possible,
given that we have a choice here. Feel free to ignore if symmetry
seems more important.

