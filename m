Return-Path: <linux-kernel+bounces-867737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B8C03659
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F3B3B46AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C09D17C21C;
	Thu, 23 Oct 2025 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZO9fLAC"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A3184
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761251527; cv=none; b=s822AAK/YbyGA00MxL7D3c5Q0spEmotbPuoVo254zPkXPNy2Qsaqns7cA7gUk8HT4YKbLgMKvoycSvR/h+19lnHqWlkUWG6Eh/jjB7w7kvXSFMgZDDiRMjLoDAlhB9Yqxt86YRjmE/TPDTS+qA2W6mPCoQp6K0kkX2M5rGlnnTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761251527; c=relaxed/simple;
	bh=236312neeVJG7LyErAG0496ByhyKDmHLJg+2zCLiD1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4xs8Y3QneEbpjzzZ+kRI6rUq4iIjzd+Cje1dCeiNXDqYUuXKqz7XxEZn0sGlnhT9C2B+jCMsXsCDybx6ZR1of+ESZP5QRSnCj57XiqieWuobj70cet+mP5bnltuC+4++8RXRbj6WEu8qfXxf0sLe+SiJCIIsBXQIqqwAvO5euM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZO9fLAC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-290d48e9f1fso15825ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761251524; x=1761856324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3GbqcC/WnvG2wxuPd40YtqR08PLkAH1Q85YMJct8AQ=;
        b=iZO9fLACApYN7o6yKK+bWi9Hm9/HXvy0VkRneQGe8Uzjjqo8ugCD4TsxzYNW+9SjhF
         w4u6VjPiZgn6UmnHj674PLGwKPsQwHsAyzy7JcsYA8uYR1xYwy0InW4S4UZVyznZXPGR
         pwu9gn63tx4H3KotZDj+x/0aG3nvlcjggpRykXKayBVx9R640KVDvivWnj0n9Rm0ghTj
         uOeuJZsv9PQNubcDh5+jIT2MDpCNNXbNbaxbR0JPQ6IP8cD5gTEsPfGKE7/ikDscKnmR
         ke1uwY2NGTBrikcfI72yY7lMV7HzWdGCZ/bjBeL0i7cWG/3e/s5J3fzaza8iOysJqdx+
         y6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761251524; x=1761856324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3GbqcC/WnvG2wxuPd40YtqR08PLkAH1Q85YMJct8AQ=;
        b=pX7TVOS/5RA1d7U/i2eS/WZbxeEmEXybkuMB+LjN5yBYnlpdAo6uYDfvZblqKjIVQs
         /b3A+qaShMcMBY90L4iSgNmjqAsvJeEmEoSQ/zDs78wAfND6zsj1PZLLGFs5V/o2RjVv
         Zop1IHXE/D4c1gn7xIjjYgs9uXh0RSkWrEvNcX/1CjTyynHjlH4YVV6gLkg9InSpzPaQ
         O17XFkDlDmEwdyPDCqWkJOo9KwxCSeT6DLhnurmSokKc/eD8Ae3919A8vB1Fi2aA6iYo
         xladSI26qrr/pXLReHeMIIwEVBE5riJ/Ut0MqZD/zhZymx9Bd45F9KTku0oogd5VL0u5
         Olzg==
X-Forwarded-Encrypted: i=1; AJvYcCWeN0sUoKY0cDBW7AS01G//PcqZ9+LiNIUEweX0dMbeIhX5htUSAXljhiPH+TZ47srVcZqCRgypOyVeT2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx931Prt/ObdQRFGyqKThyPnMPLsQF6dcDuNRKZ2xMDHnMWHAXA
	Cvbt8pjOlMZgny8fWc7bU8dpxMy6h22VHuIA4bCS5HM/srMRDeSTZjCVNsHS2zZigXvmQlGKgZO
	i/I3kW4Te+o22gf1A4tZXYRjbR1gAv2XyNpQPXBNL
X-Gm-Gg: ASbGncsF/0Tj6mkDTDYRWCsV1/Cf9CKd6A5qpOuJY+wfv8ruDngD5VsvlvWoiimCj3m
	VIYofMJOBdnb9SU9R1JLPxmUHDLBxPJIXGnOzS9XHRjtCjtHwiIqdTgOQ8v0F6u1KPvXIcqpvqK
	X6x0RyMgQ0W6gkk2r3JGyCFMUa3ZygmGK79GUFLeo4VQ8RiCvlNfqbuzogVdDLVGqjR/VtZi6v8
	0MM3mVNoPaeQ3un1kY72qqXdiTS7bd3tiQc8ROYZWH8UePSTUQSpHK6j5vTuABPmFG3LM43IEj6
	phZWaErvgJl7PfgJhTLTRQ1PkFuWbqk5PqbJUhc=
X-Google-Smtp-Source: AGHT+IFqYTO9OhaGbvTF+gc6PUoCmonC3RLRYQV6NT0QUylhUdb10TIEy7SswDyj+FbJvNKxFB7OdRyEx1bzxgb75ys=
X-Received: by 2002:a17:903:32c5:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-294894eb3f3mr913195ad.4.1761251523468; Thu, 23 Oct 2025
 13:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001025442.427697-1-chao.gao@intel.com> <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
 <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com> <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
 <aPiEakpcADuQHqQ3@intel.com> <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
In-Reply-To: <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 23 Oct 2025 13:31:50 -0700
X-Gm-Features: AS18NWBm1eSgqBL9wFCx_Q-96MkmMC0i2iF8YLZuC-hfgkp5DIWbNEmuyET8Qgs
Message-ID: <CAGtprH9bLpQQ_2UOOShd15hPwMqwW+gwo1TzczLbwGdNkcJHhg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: Chao Gao <chao.gao@intel.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>, 
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:42=E2=80=AFAM Vishal Annapurve <vannapurve@google=
.com> wrote:
>
> On Wed, Oct 22, 2025 at 12:15=E2=80=AFAM Chao Gao <chao.gao@intel.com> wr=
ote:
> >
> > On Fri, Oct 17, 2025 at 05:01:55PM -0700, Vishal Annapurve wrote:
> > >On Fri, Oct 17, 2025 at 3:08=E2=80=AFAM Reshetova, Elena
> > ><elena.reshetova@intel.com> wrote:
> > >>
> > >>
> > >> > > > ...
> > >> > > > > But the situation can be avoided fully, if TD preserving upd=
ate is not
> > >> > > > conducted
> > >> > > > > during the TD build time.
> > >> > > >
> > >> > > > Sure, and the TDX module itself could guarantee this as well a=
s much as
> > >> > > > the kernel could. It could decline to allow module updates dur=
ing TD
> > >> > > > builds, or error out the TD build if it collides with an updat=
e.
> > >> > >
> > >> > > TDX module has a functionality to decline going into SHUTDOWN st=
ate
> > >> > > (pre-requisite for TD preserving update) if TD build or any prob=
lematic
> > >> > > operation is in progress. It requires VMM to opt-in into this fe=
ature.
> > >> >
> > >> > Is this opt-in enabled as part of this series? If not, what is the
> > >> > mechanism to enable this opt-in?
> > >>
> > >> For the information about how it works on TDX module side,
> > >> please consult the latest ABI spec, definition of TDH.SYS.SHUTDOWN l=
eaf,
> > >> page 321:
> > >> https://cdrdv2.intel.com/v1/dl/getContent/733579
> > >>
> > >
> > >Thanks Elena. Should the patch [1] from this series be modified to
> > >handle the TDX module shutdown as per:
> >
> > Hi Vishal,
> >
> > I will fix this issue in the next version.
> >
> > The plan is to opt in post-update compatibility detection in the TDX
> > Module. If incompatibilities are found, the module will return errors t=
o
> > any TD build or migration operations that were initiated prior to the
> > updates. Please refer to the TDH.SYS.UPDATE leaf definition in the ABI
> > spec above for details.
> >
> > I prefer this approach because:
> >
> > a. it guarantees forward progress. In contrast, failing updates would
> >    require admins to retry TDX Module updates, and no progress would be
> >    made unless they can successfully avoid race conditions between TDX
> >    module updates and TD build/migration operations. However, if such r=
ace
> >    conditions could be reliably prevented, this issue wouldn't require =
a
> >    fix in the first place.
>
> TD build operations are much more frequent than TDX module update
> operations. Retrying TD build operation will need additional KVM and
> userspace VMM changes IIUC (assuming TD build process needs to be
> restarted from the scratch). IMO, it would be simpler to handle TDX
> module update failures by retrying.
>
> Admin logic to update TDX modules can be designed to either retry
> failed TDX module updates or to be more robust, adds some
> synchronization with VM creation attempts on the host. i.e. I think
> it's fine to punt this problem of ensuring the forward progress to
> user-space admin logic on the host.

Discussed offline with Erdem Aktas on this. From Google's perspective
"Avoid updates during updatesensitive times" seems a better option as
I mentioned above.

To avoid having to choose which policy to enforce in kernel, a better
way could be to:
* Allow user space opt-in for "Avoid updates during updatesensitive times" =
AND
* Allow user space opt-in for "Detect incompatibility after update" as well=
 OR
* Keep "Detect incompatibility after update" enabled by default based
on the appetite for avoiding silent corruption scenarios.

>
> >
> > b. it eliminates false alarms that could occur with the "block update"
> >    approach. Under the "block update" approach, updates would be reject=
ed
> >    whenever TD build operations are running, regardless of whether the =
new
> >    module is actually compatible (e.g., when using the same crypto libr=
ary as
> >    the current module). In contrast, the post-update detection approach=
 only
> >    fails TD build or migration operations when genuine incompatibilitie=
s
> >    exist.

