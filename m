Return-Path: <linux-kernel+bounces-890920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97FEC4163A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28FF3B305F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210372D63E3;
	Fri,  7 Nov 2025 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azlffg9Y"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A29287257
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542519; cv=none; b=BudPN+9nzOE/RXQSK1M8wsX87mi6TiyfX/Ss+PHhh6EOGETUuzjpqK/6bS3hZnKUZA3okY1SsBZIPonBNTYjEI3Jy7m9fGjx1RsKh996IDruY1A0k6owZaVF2r40y/b8qIjJlEpFy7nE6Qt87TsSzM8/BL0Y/rxP5O4D1f5U93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542519; c=relaxed/simple;
	bh=YEApJjb+BKSUJEihP5IIJwfQnVF2BrNHxqVRXXY4P7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFsMpGFKXfu67s3oRoRKYhwxbjy7CfApqBTJhgKdErGziCJF9lY3zS2PMfKLbtMxLaxNlpOpkVOrYZ+3PWlHc9TrQG7qo6hKCuSXems/ixaWBOhqXFqZ+GTGQKNbradvlGXo/uUWkEdxpX+zaG7zoTJ2R7RKJC4oOYRl1gAaNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azlffg9Y; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640b1d0496aso1339a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762542516; x=1763147316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YEApJjb+BKSUJEihP5IIJwfQnVF2BrNHxqVRXXY4P7U=;
        b=azlffg9Yk8/EA28FE7gn+RB2mYHYJK3rOSM6wH0cyeuTij2n2pznAeqjxOTprjmWrz
         DVcUcLvkiVBRXT8UR1T23vm2W2cTZVzx6LEGLYDW1shuCostxGbgB+i0IV0wvX/8hEjC
         yv4Onqae1z8ve9b3xCL2e8r/hb/J072rbp1XBbL2v9BMnUCT1g3auSVwQ5iSHRaSneYo
         XCIWQ7+xJPPzAUmAhEDtUuxScZeiWEIlpzPOPCtZxudkgWFNLGNyvKLts3zK3Wcn3scx
         p9e7t3nrBriQJXsv7f1aV4yUIeP7I8nTBx6ea6MD1oWfI/R1AQB6nAGxY1G4xnVklALq
         jYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762542516; x=1763147316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEApJjb+BKSUJEihP5IIJwfQnVF2BrNHxqVRXXY4P7U=;
        b=DmwDsolxWC5yI0EDv3lb55sin9FFeQasRVVtayOXAcl1rRvSb8Qp0j3w/fLaEftHKA
         5R6cTJJPukjvUi7As1wQX5mhtJP+WeBrQRzpkCWq9pidkN39d6oalmjpPDve1gLYiqgJ
         xrMlPvbzyi9UTSnkBL6Ojqm6xE0mOgftt/ViPMxAXrpZcvCWMMWWcpa/P3VfKqJ2HAh/
         dl52Vy+pit783x7CuAM0dFEo9lUWJDAp5vMWG2NrRoKnM6A68Tmr0cUWKXJaxwg6yv2v
         p+GgFvrjudbTwXOTAy5Ijkskl7/M8l4jAVueNRLBFb4178q5YHqv9zO24CMdBxF8PP3I
         yzHw==
X-Forwarded-Encrypted: i=1; AJvYcCU0F/3xYd1nYDpAsiA1qXtGZCHMzrQxi4oFPA/McGiupQ/NdgFlCV2TCzvmW54luCg2bb3iVZCBsCvY1YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN9isRDLWI8fqwFfqg0h6ml0W+TIjO+vK1I7cR0kk5J6LYhy9g
	jz08oZha9l5tfzDFPVlvPFwCaV/MYKaRPfELNdT349dxBcg4TgJkBsolaTe9U7u4IbI3nckRv20
	u8wjeEJ9ocrFFQDqaxNfkZuriRX+uIEs1uSxc7MX3
X-Gm-Gg: ASbGncseSdwQMIKEce8cnj4akDS2ZCaQX8+Hl6o5NtH/685LnP97xbnhROA2Z8vs+x2
	+8l5o0AdHapQJOaSwHDPB09/B7bclSaODGFZp7edOyFk2YHMBQqSwbSmepsEDHcrvJXqejQb88F
	yoW1I97AW1y0j4kd18G0ad273rJ1hA6FPEezKTj4VG3S/fKdMSwh9W/UyBWnoFdcbyTQVLyqD4T
	lXCFofYY5gGcc2kfkJEHnlsJxYlbAF2LftN+hImy1BWKDLtMx+RU67/fx39
X-Google-Smtp-Source: AGHT+IGG6ljG8dQXrbPMHMngTWoRxuoBwiYTf1g+loJabph/3sJvjF+CAfgur8C+kI6DxVyO7cJEyTRIhbK+lyOGqDM=
X-Received: by 2002:aa7:de05:0:b0:62f:9f43:2117 with SMTP id
 4fb4d7f45d1cf-6415d3ae66cmr9769a12.0.1762542516150; Fri, 07 Nov 2025 11:08:36
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101000241.3764458-1-jmattson@google.com> <6f749888-28ef-419b-bc0a-5a82b6b58787@amd.com>
 <CALMp9eQJ69euqBs2NF6fQtb-Vf_0XqSiXs07h29Gr57-cvdGJg@mail.gmail.com> <93211ebf-1b8b-4543-bd1c-f3805a54833e@amd.com>
In-Reply-To: <93211ebf-1b8b-4543-bd1c-f3805a54833e@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 7 Nov 2025 11:08:24 -0800
X-Gm-Features: AWmQ_bkz3gjPINUjSPU2FE5U7CJsGeQ2ZdXMf9L_NIA6-76979_FlFZxjte5sfY
Message-ID: <CALMp9eSVXX4mdPP-t_m9R553qaRY_i5q=+1d-9cC3ZuBkynxOA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: SVM: Mark VMCB_LBR dirty when L1 sets DebugCtl[LBR]
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, nikunj.dadhania@amd.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matteo Rizzo <matteorizzo@google.com>, evn@google.com
Content-Type: text/plain; charset="UTF-8"

I'm going to rescind this patch. Yosry is going to handle the
situation differently in his LBRV patch series.

