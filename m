Return-Path: <linux-kernel+bounces-730729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C04B048BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC893B4B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7308238C05;
	Mon, 14 Jul 2025 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdx5CKLj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D610229B0D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525588; cv=none; b=JqWA2LdG26fSozWzSmjdOa2SUuZW/enEsGwk+WIn4vJjuJaCnSiIKShk/7GztKUMmi8bpfKXxcpVpHgp7fef+oB2ogf71MFkNZXnTKBpd0uhiORjY5Jn5mcbxHs+MXA5ahDMIeEFHhEUGFhP+yEU6FWbaDS+VHHTBR3C1OeU//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525588; c=relaxed/simple;
	bh=a5y/8SUZq0rdm2xQZuA/Ya2xOqAO/MdvVu8D3Jo9BDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJRf5j7GAc1JwNTfi8VPVVFEyNFrVkzZTe+Vxg/krHdY9tOO2jX7OzxaOnU4jIbRRVNKoqNvGqFSeDDqlHsJnm++xddvncchjLMhS9k2SeFuMnlJ1hFJuaxmY+MQqUTUGrz99MwQciPZx9cfhKZPPlhZNtb3GDy6PEsihtQqfek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdx5CKLj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752525585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5y/8SUZq0rdm2xQZuA/Ya2xOqAO/MdvVu8D3Jo9BDM=;
	b=hdx5CKLjjObDkhxfqqEyk+jHihqqe1FXkiYcBMON9SEMFMKDUdcwpPr6+nasye1xoN82d7
	8WO6JzeO5tRFzhETQx7NXyw7JJgZWrZ2/Gwmm/gYuP/np6lBHfcVJIOpRoiU6DELXY7Zrn
	8FSrEovlQ3GxdHmXFowCAcF4e52TtUI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-djEX2LNgPDqKI77LMujOyA-1; Mon, 14 Jul 2025 16:39:44 -0400
X-MC-Unique: djEX2LNgPDqKI77LMujOyA-1
X-Mimecast-MFC-AGG-ID: djEX2LNgPDqKI77LMujOyA_1752525583
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae6c9aa2c93so409114666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752525583; x=1753130383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5y/8SUZq0rdm2xQZuA/Ya2xOqAO/MdvVu8D3Jo9BDM=;
        b=NtiGqod7mDyZ55zE9Pfn6Y144TIMAJ0nDukTaAZqKVyp68I2knlf3SoKd2mBJrxSwU
         PCOMm4TJXpKWE2TZE3c1EC7c4GIe19zhbx3BsYbqutU2oU5pmjZx50sh/qn7Z6TQkzdS
         YhZEA4shvK19xvuXhMcCqOhTb4SL0Pr5cjXSm7nY4eKuO0SEcXbQzePtnLH1pQ2RTN9i
         cpQjtdkF7fkzfcSqZD5wdJlQBvRbxZT1m/xMjRXnm1tXjuqxACWoBwhVM4Fa356fsIYo
         uAtQHGTJNTz2oM0zs5eEIuEMDVu9hR1JeIPEXqoqHlr83N7i3WdaW3mxr8FeuaHJnpdU
         SEMA==
X-Forwarded-Encrypted: i=1; AJvYcCW12IzlbvRYFqTh1lI1MbIcdsx3dP+eyliiXy5rWFrIc2/yhd/fukPI/TMO8qOkIjyyWJy2p/W6xvDLPO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIG2PQ3QqNeYOFpCUV44Ntjp5vjBP9R4LOE9+Tqaey44J67+zS
	4K+59QLk7Yq59Kjrtr6y6W58lzY7s/MKKbTdFEWWX+azdNgiGDKzFePN43UzefzPiorBKMPLQek
	zOBz6KxnrVilJG8nDGfBkq0Zrs44GijAQcofdOJ+D4o0N1lnd0GrDXZ6CVoodhYCo4otRUeVNu/
	7csdOLlbygN9dbOmOYfwsCAQkErDcw5apcfFlanC3G
X-Gm-Gg: ASbGncviGy/MWy5MH2mzUyDHG0fTUqaHy70yptvVeMvuRpGVOzZeUzQ8EZXeG6rJHgz
	S2kZiuLj8OdSEzRwrlfKuDAVBYHztkTU6Qx5o2VAxv72zKHNwKguJ3kgKkvAQroFisJDFMuvNEv
	9coQhRFoIpjbdnUvQa+pyI
X-Received: by 2002:a17:907:84a:b0:ae3:a240:7ad2 with SMTP id a640c23a62f3a-ae6fc6aa6dcmr1561812366b.2.1752525582629;
        Mon, 14 Jul 2025 13:39:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtOtCIDm5iIRXUzH93pKL+mJg2YxukWxSYyuAjAlCNSpCWGK9PKhS/khXgGAJEgay188lilBak/nz6CZiqGvQ=
X-Received: by 2002:a17:907:84a:b0:ae3:a240:7ad2 with SMTP id
 a640c23a62f3a-ae6fc6aa6dcmr1561809066b.2.1752525582243; Mon, 14 Jul 2025
 13:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710-sound-clk-round-rate-v1-0-4a9c3bb6ff3a@redhat.com>
 <20250710-sound-clk-round-rate-v1-4-4a9c3bb6ff3a@redhat.com> <c321ed9f-7906-4a92-9202-efb46343ee91@oss.qualcomm.com>
In-Reply-To: <c321ed9f-7906-4a92-9202-efb46343ee91@oss.qualcomm.com>
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 14 Jul 2025 16:39:31 -0400
X-Gm-Features: Ac12FXxNfqVieUoHNPgnW-EodFqKMjypw83pf906bEoCpdOuQyrxKsmWcymmig0
Message-ID: <CABx5tqJzEMUXz0Cbo5siCnwKp2MVON_oGgMnGkb_cg1zv8k5nw@mail.gmail.com>
Subject: Re: [PATCH 4/6] sound: soc: qcom: qdsp6: q6dsp-lpass-clocks: convert
 from round_rate() to determine_rate()
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Oder Chiou <oder_chiou@realtek.com>, Srinivas Kandagatla <srini@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Maxime Ripard <mripard@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Konrad,

On Thu, Jul 10, 2025 at 12:09=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
> On 7/10/25 5:51 PM, Brian Masney wrote:
> > The round_rate() clk ops is deprecated, so migrate this driver from
> > round_rate() to determine_rate() using the Coccinelle semantic patch
> > on the cover letter of this series.
> >
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > ---
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> come to think of it, there are a lot of drivers that can not
> do any rate rounding - perhaps we could introduce a NOP implementation
> in the clk core that we could reference, instead of copypasting
> int foo(...) { "return 0" }?

I'll look at that for a second round of cleanup once all of the
round_rates have been removed from the tree. From what I recall about
the ~200 or so round_rate implementations in the kernel tree, there
were maybe only 5 or so that cover this noop case. QC seemed to have
the most from what I recall.

It wouldn't be hard to make a Coccinelle script to look for the noop
determine_rate() implementations.

Brian


