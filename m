Return-Path: <linux-kernel+bounces-850102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8D4BD1DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CA23B49FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9819C2EA480;
	Mon, 13 Oct 2025 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dS4uuKbS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277CEADC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341752; cv=none; b=rO4MxjWzHbF0lKyMpUo3vpsHtf5f52C4/lCwMgF6PvJmc938oRvyhhNAJsg9Do+7kH2FTZozfXobGA37ZTRr+WdGs/fRQ0fHu0jq4cyXM6jG8rgDVMKMsuyMHxgPgs0RNGVXiVbVawXufYqrHZXpdFsJFqhFfL7W/soh/+wmNSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341752; c=relaxed/simple;
	bh=jX3zGRqZI4Jml0uk5ubCHiZ727gZMt/y0Ls1cBpk+ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAxYtptj/dy7aN01J6WQOqdCHFihMqSJx8XFDVvcc0NkPoBJjO//eyq/7vvkpx5cbtSUvI+6ae5LGfMCmTG9xmypX3tPIj1CAw4q68+5dtvUgBkRI+A1r9SAJsWouZjM7av9NF2MKgG2kXhoMtzh4Ju9BK6ojTLGgg6JI3vmJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dS4uuKbS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760341748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jX3zGRqZI4Jml0uk5ubCHiZ727gZMt/y0Ls1cBpk+ZQ=;
	b=dS4uuKbSm6ZXMG+HnEvDA9GuBQfEXuN/Bh52YWtc+LHyyrVMZ5YQpNupUDdpYgJLVxoSuL
	xCOVR4qW6j0ve/qxzXXPGqYBQt0D05aViK0BqyZ/J7rqzJkOEjtCXAz6U7GbGJvYL5yxIw
	fL1RSntjMi5Njpb92yvDNnkENdAzmqY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-BkGs75smOSe1klNjlWE2qg-1; Mon, 13 Oct 2025 03:49:06 -0400
X-MC-Unique: BkGs75smOSe1klNjlWE2qg-1
X-Mimecast-MFC-AGG-ID: BkGs75smOSe1klNjlWE2qg_1760341745
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b548c516b79so364312966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760341745; x=1760946545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jX3zGRqZI4Jml0uk5ubCHiZ727gZMt/y0Ls1cBpk+ZQ=;
        b=CNCY0niu4BfXBEEP75WfwbsK+NBCV+Th9/0ItUMmynS/oPYUqQ6OTZ9GxYTrJKvTVm
         Xl3AaabhPSMgMb/QLEyjC8bmqOD0sgiSKY4CtBfNXyH0021g3Ddqi2EcYy/sqai6jvm/
         SkWbWAdJoAYS9EIK4lxeCPeGihIz1Zk23dTFYVnY6O0s6gj7gxEKGxnAgk37aX0sdE2l
         KsLaboGy6f2hK3VhjJlOICi94/JeoW1s821Ss1a8IhZSpO/mOzVdauXnrYOqgIpTvs+J
         WwTLoDwLSkZeT/1qNU1QAXqrEEN4bdmbdxc1cQrjHUBjcoJiwyePZy7SU4eOCGCPbjSe
         Wo1w==
X-Forwarded-Encrypted: i=1; AJvYcCX5Z9siWLGC2dNWmJsKkASRE31S84vMkSNQ6w/DRovAnvf58rpYOBlc5IP5Uv7nUjehCu+ZPoikDThhdvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrkJNwydxCHajxAIM1DhZQMOKEy0s92RrJDMC6peukjfuZ+mB
	Vnb++gcHaoHgeVN4Ds/NS8MtFeToVcXwHP202AC8bB0nKCMIznY1U2DEd26pXprvqPJW8Dh4Fnw
	Op89W9dERgWJD2jHxzRO2lPuMTRsXd+T6sgcHgBZlYzKJy1oiULhgRxT/wGMNJ7wirEnig1Oltp
	9a0ARFcOGC/tGrHTRx5xYTbQaGbYGzrqS/bekeMvHy
X-Gm-Gg: ASbGncunHt6mr5DL5uilhoEk2p20gXroCcvjWB4kX8VEQ2wIzQvvfrwra+lTkdP38aH
	8aUJbM1kmOp8wZcs0LhmJMl3xRSafx88olnFrKD8gG1kh7HryD4uDjulNg/VkqbGpg4oBDlJMkg
	UH84hRxFhrNtMKeb4vUhelHM7n4m3ZKCJCmpxjH7/tuAFQPMPbmiA=
X-Received: by 2002:a17:907:3e84:b0:b45:b078:c52f with SMTP id a640c23a62f3a-b50acc2155emr2001868866b.61.1760341745276;
        Mon, 13 Oct 2025 00:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqhrIMBzv7FVKIJZY7pAeTJyHF93qi5Y95G5zE6lbLfCze/pnMZ8A5PNK3mFI88ZP8uZpaMEUlkIjGra4JkTw=
X-Received: by 2002:a17:907:3e84:b0:b45:b078:c52f with SMTP id
 a640c23a62f3a-b50acc2155emr2001866666b.61.1760341744888; Mon, 13 Oct 2025
 00:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012071133.290225-1-costa.shul@redhat.com>
In-Reply-To: <20251012071133.290225-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 13 Oct 2025 09:48:53 +0200
X-Gm-Features: AS18NWB8lS_HxhSgQA3ExX7TS8082JQF5u-zIBQhVjx3OB8WMoHRJEDOv7TxcbI
Message-ID: <CAP4=nvSou70FUBF=GTKUziBfV5tXFKLcwgyDwcLmyA4y0PdS9Q@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Remove unused function declarations
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ne 12. 10. 2025 v 9:13 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> Historically four function declarations remain orphaned or duplicated.
>

For future reference, it is helpful to include where exactly and why
those were removed, especially considering that three of those four
were only removed in the most recent tag (6.18-rc1). For this case:

Commit 2f3172f9dd5 ("tools/rtla: Consolidate code between
osnoise/timerlat and hist/top") removed
{osnoise,timerlat}_{hist,top}_main() functions in favor of a common
function, run_tool(). Remove also their declarations to keep with
source clean, along with parse_cpu_list(), which was replaced by
parse_cpu_set() in commit 894c29c76b2b ("rtla: Change monitored_cpus
from char * to cpu_set_t").

> Remove them to keep the source clean.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---

Tomas


