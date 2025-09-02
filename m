Return-Path: <linux-kernel+bounces-795748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7DEB3F755
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2567F206E77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882AC2E8B66;
	Tue,  2 Sep 2025 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuAK93YH"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394192E7F27
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799994; cv=none; b=Ws4YZWuWHVUGuBWAqNAYXGFuv+tbYSA2wHnoGkLfIrOU8QCKMJ/UAzvl6li3WR9WokZ3eHpEDR1x6iGZ6P4HcLN8WJ/bpK/yY2xjWohCqVsZYv7jTFNOsdYt76uMoQBdfCCFW50bkgq88O/CXEgd5KddrnaXANSnROnkWK732qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799994; c=relaxed/simple;
	bh=tebRK0QcMgpMQT7H4oKZqhEct4KUpLNswRIw/gQ5Jd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBNhx5sQKqn6YnINMtPnz5v+YsJO/CUTgah3+NuncsICVxeSOCY8z0Zn8ohobE5golHwsjkDUBk7qauq7i4lL8faraosC0QfSLlzCWwqZY5xjbFcmhPg6bfsKXYO7UylwhhBIFOO33dtYPRY9Es6d8+zGaGP7W7DZwSZ0agtsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuAK93YH; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b327480fd0so824591cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756799991; x=1757404791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oNeLWs2qHyUDts+2iHePFK0hNcgX1eWBxmSFpW760QQ=;
        b=uuAK93YHHFDmmTKFvJYZDd9O++g6IPIcA94//Z84CVnkw5SlNIJENssyFlmJQnIoOc
         Yr5MU8Z2/FESdJKdmmUeqq58bpHcwTeTKTs7sTTJjAcV1zuBfS8hv6dBPL22gBbIyQAe
         4J+pKhiLL7uhoYWOxEdTH3hvLotk0PfHyZcXJx222qovWVtLAsLYRNKOLMHuHDiWULAv
         buYbVvW+0ne9Rc+EOcos3+FJWQkJDR4mZFdZegpDyeWOj5XVAn6HNLwPLpyq0edSVoGC
         F7hU/z5j6nUXMycY5kqxqjS5CUO0ARO2hw0up18N48EX1CViF+Khh8pBfbpR8Qg/h/kv
         fQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799991; x=1757404791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNeLWs2qHyUDts+2iHePFK0hNcgX1eWBxmSFpW760QQ=;
        b=RImI8gDff8VzSXaGsvP4SUHPbmIIamJAafxMIqayL1YPCRvELy/vKDsAIpFHUmgOY3
         zZ1ioe9d1kMQkEB5IZQY5yO/cUf/ZN1AOeW8aaPMh3Di0/+dAC1/91p0SwOC4BF6fizM
         I2ByU1Z7pN36+vUzjK9GLemLefONkJ7uLEHkdiP4P28r030TJPtPuEq9xQXb9Mbdx9Al
         yCg5mrb+xMJayUmVm+MTI9LdXHh0OXmA+NVBaKgNTz2zdqtsx/VhH4GHgcNWTU7Q6V5G
         XUFUh6lPtmScLzlWBkxlpKtCGrLfr7pwXYMLBfgr3IA+DPsB6EA/LSTxz3I+MRn3AoXr
         iDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKe88BLHgG7anuIZln+bLBUP1KLWpT0WCimNkhBhQgyurJ5+VVXaTPdNK9zn4Ukf8qWYEVCGG/yKZVgu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg00vckJNcPLATvxP6Rw9+pjmep7zNWFHIBAOL7t17t5eGrAwe
	ztwPFFpzUzollkKRtyXTOKirkzwiV/i+oyF99cq14AmO56DKdbx8Dzyeij4dJ1J3MlDVr8dUANH
	xIgMJMw7AdhkVQBq0Pp/iK5ZppGjCLJvvI6Mnorad
X-Gm-Gg: ASbGncvQLeR9MwE7wWBIejBuilndRQ5kHS98+FN0TwDhyu7WenU2Acge6Ycrj0t4jR1
	6WaqdVztRjZ31LKvyMrsHxCozhXRwOEUhrsxkpXr6JSqgvODttOtDSIWZA9/XSZqgzWiPGCGN6e
	Vp7TWitTIpA6MsTEWuLOMHlicl5wQysiSy2pyKZVa+q9p+8D8DpMtN3+jO8otIISU4cMjqooyps
	shU2JHShfVuNu3PFtDi6cg0YtfMJCbn1k8t
X-Google-Smtp-Source: AGHT+IFkdbqiMarowY+mmKOzuU9RyYySZu0bnzDQg3QNeDfxzMXfy+3OtZ2GRaaDn0H+MAu5W+vNpqCjVKeX20zwo4o=
X-Received: by 2002:a05:622a:107:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4b31b245bdfmr13130661cf.3.1756799990207; Tue, 02 Sep 2025
 00:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901135408.5965-1-roypat@amazon.co.uk> <20250901145632.28172-1-roypat@amazon.co.uk>
In-Reply-To: <20250901145632.28172-1-roypat@amazon.co.uk>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 2 Sep 2025 08:59:13 +0100
X-Gm-Features: Ac12FXwFaub6kV3Kd2ykY4foMIV_-u80DlGRtIr2iGvqoKH4iO-6ScE4yMry24U
Message-ID: <CA+EHjTxPfzDk=XmwS0uAtjwsYB829s1uZSMC6x3R6KGQ-SqjtQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] mm: introduce AS_NO_DIRECT_MAP
To: "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "ackerleytng@google.com" <ackerleytng@google.com>, "david@redhat.com" <david@redhat.com>, 
	"Manwaring, Derek" <derekmn@amazon.com>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "rppt@kernel.org" <rppt@kernel.org>, 
	"seanjc@google.com" <seanjc@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "will@kernel.org" <will@kernel.org>, 
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On Mon, 1 Sept 2025 at 15:56, Roy, Patrick <roypat@amazon.co.uk> wrote:
>
> On Mon, 2025-09-01 at 14:54 +0100, "Roy, Patrick" wrote:
> >
> > Hi Fuad!
> >
> > On Thu, 2025-08-28 at 11:21 +0100, Fuad Tabba wrote:
> >> Hi Patrick,
> >>
> >> On Thu, 28 Aug 2025 at 10:39, Roy, Patrick <roypat@amazon.co.uk> wrote:
> >>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> >>> index 12a12dae727d..b52b28ae4636 100644
> >>> --- a/include/linux/pagemap.h
> >>> +++ b/include/linux/pagemap.h
> >>> @@ -211,6 +211,7 @@ enum mapping_flags {
> >>>                                    folio contents */
> >>>         AS_INACCESSIBLE = 8,    /* Do not attempt direct R/W access to the mapping */
> >>>         AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
> >>> +       AS_NO_DIRECT_MAP = 10,  /* Folios in the mapping are not in the direct map */
> >>>         /* Bits 16-25 are used for FOLIO_ORDER */
> >>>         AS_FOLIO_ORDER_BITS = 5,
> >>>         AS_FOLIO_ORDER_MIN = 16,
> >>> @@ -346,6 +347,21 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(struct address_spac
> >>>         return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
> >>>  }
> >>>
> >>> +static inline void mapping_set_no_direct_map(struct address_space *mapping)
> >>> +{
> >>> +       set_bit(AS_NO_DIRECT_MAP, &mapping->flags);
> >>> +}
> >>> +
> >>> +static inline bool mapping_no_direct_map(struct address_space *mapping)
> >>> +{
> >>> +       return test_bit(AS_NO_DIRECT_MAP, &mapping->flags);
> >>> +}
> >>> +
> >>> +static inline bool vma_is_no_direct_map(const struct vm_area_struct *vma)
> >>> +{
> >>> +       return vma->vm_file && mapping_no_direct_map(vma->vm_file->f_mapping);
> >>> +}
> >>> +
> >> Any reason vma is const whereas mapping in the function that it calls
> >> (defined above it) isn't?
> >
> > Ah, I cannot say that that was a conscious decision, but rather an artifact of
> > the code that I looked at for reference when writing these two simply did it
> > this way.  Are you saying both should be const, or neither (in my mind, both
> > could be const, but the mapping_*() family of functions further up in this file
> > dont take const arguments, so I'm a bit unsure now)?
>
> Hah, just saw
> https://lore.kernel.org/linux-mm/20250901123028.3383461-3-max.kellermann@ionos.com/.
> Guess that means "both should be const" then :D

I don't have any strong preference regarding which way, as long as
it's consistent. The thing that should be avoided is having one
function with a parameter marked as const, pass that parameter (or
something derived from it), to a non-const function. Instead of
helping, this could cause a lot of headaches when trying to debug
things in the future, and figuring out what something that's supposed
to be "const" is being "corrupted".

Cheers,
/fuad


>
> >> Cheers,
> >> /fuad
> >
> > Best,
> > Patrick
>

