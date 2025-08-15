Return-Path: <linux-kernel+bounces-770148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DDEB277B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A686208DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B3215766;
	Fri, 15 Aug 2025 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cg+UZ6ND"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344B3D544
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 04:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231390; cv=none; b=DG8oWB1e3GP007XPBLi86IHZWosFofLqeglL4/GCAtSvfCsDit78AW0uvQQPpofGEK9UyUEIQ4s+Bkq4TpXyheqacKTST/AwIZVKu8Z1OqzXYpJeblwe9uHZZ43JVZYkpX36D/s5TFGNmpt4Lq4RT7scozMVeSlPvTyt5OwR0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231390; c=relaxed/simple;
	bh=O/FxN8kn9NYDBV8o1U98GYZDA4orJ42IZyhISfK8GTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lab6dfnaI/0BDsai8rvy7bdVBcoLxgu9qjkXOzejXiW96pE9V7rxf3iBfnTSwsPPLTvLhgUqWCZUC86Tyir3dnY0qqCEhabPBWOnSO4gHZL6Es7vokT7V7Qh7nqQuGL4MnOb5JNIIQiigzXzsy5UZIv8sJJYALYOAHaZYl7MyOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cg+UZ6ND; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b0bf04716aso119631cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 21:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755231388; x=1755836188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpDFenZ92jmpl6OY4EnKwsw0mULhQnR/+GZQK02VdBA=;
        b=Cg+UZ6NDBN2hB3Xb9tmSNLf4pcLTWP+wNZWnkKt96aakq+WwnEhlwRuGrBFxu9bsh6
         HxPgH/lK6Q1J4vaJ/9TrHiNlkR4KFtcinq1osSIeShCbXJ7biJgLzeO2GIAZjyvf9Bdc
         fjzHX1y3FU2wShNKsM4hvzX82eKjiDUQHovKrAwcOnq111QBSFa9HdvlzHj6oW2MZBEl
         X5mwCexaZzq7jGWRhI/0JkwEkE8OlaBh0wwWMtMxOSZiQit0J1qYTmzDwSxgkuVtQ4qw
         GF4Pbbm+gfghWTu/5iYYN/12dewzbc5NY7Qkp5v7nheTZVA5ki+n1v8q20PfeRNm22ZP
         S8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755231388; x=1755836188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpDFenZ92jmpl6OY4EnKwsw0mULhQnR/+GZQK02VdBA=;
        b=h3V5DdrfZSW/0s4RnSn3uQPET0i0ZGGhWHAJ8aUQMhIoSS6KT8vZ5/lYOYp0B8n1zZ
         knbhWdKz0lXcuf1+0yt453sSnaXzS9S6vjlfXvuGCMu+bUoplvqj9w6MntRhbg/mQrfC
         z3GSwCfU05EY4K6ZRJ1h4KnM4EMLUQyK0J0eVvm9XqlkKTqXLkuAs+kN3p3eKFa0DJYM
         W7CQmyoATNM3Jm40cIDqZTjCFWJ13dcb9g99wr4DfkQ3delCgDRXnV88Qi2PwUVqjomT
         x2/Yn9K1jatDAoOmEvq4+pAn+jkm9ERHh1Dlo2BWSRgDfGZQlYnYKNHjJY2+eCRR6XvR
         cqhw==
X-Forwarded-Encrypted: i=1; AJvYcCWMzzXNBASDcGIO8ExDeF++BInfOArrGAzR8p8tYWcXl+k6g5EM/EFGDiNykU4Qkoh1EhJbFbiJGUCBfjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl84Ro8CX1pX4dkVP8GyOpwoX8lzz7iueIrS5WZbImyvaAq08j
	kLF7tOi+QXhIDYoVXF24cgjOKE0kvdKEDAQroSXz26T4oknvkNlQZ5XSvZSabqovZnhtbhyulIO
	sow45M/CS13DN6NSDUOOLtNZYSDUO1HAHVQly7aZH
X-Gm-Gg: ASbGncv7zKspqLy5ylttVIGnGlYRl3VpJfialKIhVZfeFwc7DZHR0+namJkM2lxrduA
	TswrMFT9+2Ux8Ahg3Qiq2yetgKarCULRQBiUaNfbS1LAyVYDOUrADhEVxzUtxbroRQWAVeDu2ob
	zLn1BYRnfUgudaX+rO55euEg6YD5BJQoG8hxGAIMumReNgci4M/DNtkpW++IHknyuyC+Kgyb2Dv
	UPYks3WaFtER+g5CK0kLHtitr4lpo/OtZshGZjQPvyWTLNAfqna9Cz/
X-Google-Smtp-Source: AGHT+IGQ/AlNfICvvkt7ASAAIexrGqodn0Sbi3YcqYgfSCwFa1R7Fox6A8C8UyOkyr1Tqf8nyrhWfjALWMTt1RKtaZQ=
X-Received: by 2002:ac8:7f13:0:b0:4b0:82e5:946b with SMTP id
 d75a77b69052e-4b119db8bfamr2805381cf.4.1755231387365; Thu, 14 Aug 2025
 21:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-2-sagis@google.com>
 <aJotMWGzChQq41oz@google.com>
In-Reply-To: <aJotMWGzChQq41oz@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 14 Aug 2025 23:16:16 -0500
X-Gm-Features: Ac12FXzup_S7jlhDOo8ZQRNApTopN0mRbrvYTez7vW_1j3Bwr78GTowA8j21oHs
Message-ID: <CAAhR5DGtLw=B1C3+aijcXWQFP+bgR95cCULdF9aE-+O-wXV+Gg@mail.gmail.com>
Subject: Re: [PATCH v8 01/30] KVM: selftests: Add function to allow one-to-one
 GVA to GPA mappings
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 12:49=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Aug 07, 2025, Sagi Shahar wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > One-to-one GVA to GPA mappings can be used in the guest to set up boot
> > sequences during which paging is enabled, hence requiring a transition
> > from using physical to virtual addresses in consecutive instructions.
>
> NAK, this is an extremely convoluted way for establishing mappings for ha=
rdcoded
> boot ranges.  Just use virt_map().  And if clobbering an existing mapping=
 is a
> concern, we should add an assert in virt_map() to verify the address is a=
vailable.

I'm able to replace this with virt_map() as you suggested. I'll drop
this patch in the next version.

