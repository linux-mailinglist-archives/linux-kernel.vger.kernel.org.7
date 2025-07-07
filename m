Return-Path: <linux-kernel+bounces-720471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF335AFBC3F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A877117F153
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E7326A0FD;
	Mon,  7 Jul 2025 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cDTLZ9TY"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60A14A82
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918503; cv=none; b=gWkHXP75We6cOA48O+/lAPcyPn0FRLmo4PfxbOykmwXQq8WhOvIkq9w4Dx3BMvLZ0Qshp0G6tYLNxvcErAqyGaHHg0nPSBETTFKelgiw4E5XwF8scBRrI0Av3koeYSMl7/LpuS9YQ25Yzh1FJqrICMEVcXPF+LpFOOFdKP6RMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918503; c=relaxed/simple;
	bh=FdEbLOGjzd4t658A5Peq0X8hOkXjkWfiWfkvvcSRkzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSurt5lreguTK5tR8qvTn2SY20g0LqXWElS/mIEYv9Q6JeBbqTJ/kcl7NfMNCxsB87Gp3RmEQYL8rZ0ALcDa5Ig4weIqooou6Hs735TuV35pm75/eeG8AtzqWn7kx8jg6JQXRGRwU6qAEoRJD8GwE6Srdut+admHNOR+oRH/Drc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cDTLZ9TY; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71173646662so31652357b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1751918501; x=1752523301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKLu5W4g48bt+4yviXuICuogMC7NETqzFrH52NDnWkc=;
        b=cDTLZ9TYrPqyUZUHPV4652jc20Kjmp0EL8+jEIzcvMMdn7pIqDLFh1Tvh9Os4/PBv8
         fUdozMNQlDAbUz+Y58iFU3mklwjb4FhT1EJbksqxoxMFn6pa8IiE2v9BH3YNwThAXAUE
         yfQCA8EIE/3Qx70DBEXLLBw2Z8UhGmmljBDKGJmV4SClH3LRGhUHIC3vOpbTBt9lsm1f
         oMOrI14nU1bk6yVZlTzpWkYusvKHVHcBEhd4KylzBaaqqNYrlrCAb6TpZo8Up8al0NUn
         CgVK4KMjKVhBc11UDWZEV7/mFfygXLU64F4YmOEHzNte+S6UY74WKleTSAM3GT/0h4eY
         CnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751918501; x=1752523301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKLu5W4g48bt+4yviXuICuogMC7NETqzFrH52NDnWkc=;
        b=CB0MgjDn9gDliNRko9kZp1TiRUCdP4kaN37nupbJLjWzcGNeB7Ev0KMP6L/E2Z102L
         kOVT5V7VMEkT0T2HkrsPddagIlCVs+K2EJsMonpbOa7W4fbYyE9OiymWqgLFU2Mh4/sG
         tpYla0XbBQgdSa74EuptT1G0QqI86FJJ0HuWv1kc/Us8f8jNTTM4l/rPpJo0/o7CqjbO
         Jcsun0sMNlqOuhgKKxi1uN68776a/I9mJldeMVMkvmxMyiXwQUcpHXc67hUh30AuGdf9
         UdK55jRiOOt2I4fk0bPgIgGPBPO5DCA7ccNebAOzkpC5V3dScEJ1ofVPmob/UPX3Ppaa
         ts9g==
X-Forwarded-Encrypted: i=1; AJvYcCUR/OSIZEpM7lcOqqTwRMfGGW7ci3JVFLj2XkvulSoh3dtACxrR7yn3igxMrepu2CsD/2IPxKC50Il7DiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYEkUJeKRZOxou97xiBXTmeXWMuMAQzJtuCx8jV0GYMwXEw+j
	ChaAQmNA8zZmaNEOQuMh/BKAKzXpJdA0tPJnhKxiV97xmUlC44Q8JBWye+c+mygMHUGKQg0c1xg
	5nTRVaWa68zGJYUyiJNlXuWYUO84xJ9ug+q6viwFK
X-Gm-Gg: ASbGncuOc/p53wnMmTN3GEs2ItJ+zDaAk17AvbHlr8Ypf15R4nT4VJBBYSdoR0IwvCH
	OeYNbUxIQUqyx2utEFqTUknZfUppmE7ZUsWQRZLws0q8jV7AOQbb7iDh10xuicw5EJRHk+Hql0e
	xUZvkznIf4Ls/f0O9uemx5U167QfcS+vfy6R+EXi3/WQI=
X-Google-Smtp-Source: AGHT+IHLYTU4kBITzhD3jz6dc9Ywq+TkUQw8uddLaok7bGe3BDRvXBsFsPv9J8pTF74kHSNW6YoQwtEeQTNvu7SccGQ=
X-Received: by 2002:a05:690c:4507:b0:70e:2ba2:659d with SMTP id
 00721157ae682-71668ded751mr165544117b3.23.1751918500803; Mon, 07 Jul 2025
 13:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626191425.9645-5-shivankg@amd.com> <a888364d0562815ca7e848b4d4f5b629@paul-moore.com>
 <67c40ef1-8d90-44c5-b071-b130a960ecc4@amd.com>
In-Reply-To: <67c40ef1-8d90-44c5-b071-b130a960ecc4@amd.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 7 Jul 2025 16:01:29 -0400
X-Gm-Features: Ac12FXweLS9FMTeg88WL40gFmqBUb7ZnlDziG-m_E-Jv5rzfO0-ilcmo0yLCqmI
Message-ID: <CAHC9VhTXheV6vxEFMUw4M=fN3mKsT0Ygv2oRFU7Sq_gEcx2iyg@mail.gmail.com>
Subject: Re: [PATCH v3] fs: generalize anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Shivank Garg <shivankg@amd.com>
Cc: david@redhat.com, akpm@linux-foundation.org, brauner@kernel.org, 
	rppt@kernel.org, viro@zeniv.linux.org.uk, seanjc@google.com, vbabka@suse.cz, 
	willy@infradead.org, pbonzini@redhat.com, tabba@google.com, 
	afranji@google.com, ackerleytng@google.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 6:41=E2=80=AFAM Shivank Garg <shivankg@amd.com> wrot=
e:
> On 7/3/2025 7:43 AM, Paul Moore wrote:
> > On Jun 26, 2025 Shivank Garg <shivankg@amd.com> wrote:
>
> ...
>
> > Thanks again for your continued work on this!  I think the patch looks
> > pretty reasonable, but it would be good to hear a bit about how you've
> > tested this before ACK'ing the patch.  For example, have you tested thi=
s
> > against any of the LSMs which provide anonymous inode support?
> >
> > At the very least, the selinux-testsuite has a basic secretmem test, it
> > would be good to know if the test passes with this patch or if any
> > additional work is needed to ensure compatibility.
> >
> > https://github.com/SELinuxProject/selinux-testsuite
>
> Hi Paul,
>
> Thank you for pointing me to the selinux-testsuite. I wasn't sure how to =
properly
> test this patch, so your guidance was very helpful.
>
> With the current test policy (test_secretmem.te), I initially encountered=
 the following failures:
>
> ~/selinux-testsuite/tests/secretmem# ./test
> memfd_secret() failed:  Permission denied
> 1..6
> memfd_secret() failed:  Permission denied
> ok 1
> ftruncate failed:  Permission denied
> unable to mmap secret memory:  Permission denied
> not ok 2

...

> To resolve this, I updated test_secretmem.te to add additional required
> permissions {create, read, write, map}
> With this change, all tests now pass successfully:
>
> diff --git a/policy/test_secretmem.te b/policy/test_secretmem.te
> index 357f41d..4cce076 100644
> --- a/policy/test_secretmem.te
> +++ b/policy/test_secretmem.te
> @@ -13,12 +13,12 @@ testsuite_domain_type_minimal(test_nocreate_secretmem=
_t)
>  # Domain allowed to create secret memory with the own domain type
>  type test_create_secretmem_t;
>  testsuite_domain_type_minimal(test_create_secretmem_t)
> -allow test_create_secretmem_t self:anon_inode create;
> +allow test_create_secretmem_t self:anon_inode { create read write map };
>
>  # Domain allowed to create secret memory with the own domain type and al=
lowed to map WX
>  type test_create_wx_secretmem_t;
>  testsuite_domain_type_minimal(test_create_wx_secretmem_t)
> -allow test_create_wx_secretmem_t self:anon_inode create;
> +allow test_create_wx_secretmem_t self:anon_inode { create read write map=
 };

I believe this domain also needs the anon_inode/execute permission.

>  allow test_create_wx_secretmem_t self:process execmem;
>
>  # Domain not allowed to create secret memory via a type transition to a =
private type
> @@ -30,4 +30,4 @@ type_transition test_nocreate_transition_secretmem_t te=
st_nocreate_transition_se
>  type test_create_transition_secretmem_t;
>  testsuite_domain_type_minimal(test_create_transition_secretmem_t)
>  type_transition test_create_transition_secretmem_t test_create_transitio=
n_secretmem_t:anon_inode test_secretmem_inode_t "[secretmem]";
> -allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_ino=
de create;
> +allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_ino=
de { create read write map };
>
> Does this approach look correct to you? Please let me know if my understa=
nding
> makes sense and what should be my next step for patch.

[NOTE: added selinux@vger and selinux-refpolicy@vger to the To/CC line]

Hi Shivank,

My apologies for not responding earlier, Friday was a holiday and I
was away over the weekend.  Getting back at it this morning I ran into
the same failures as you described, and had to make similar changes to
the selinux-testsuite policy (see the anon_inode/execute comment
above, I also added the capability/ipc_lock permission as needed).

Strictly speaking this is a regression in the kernel, even if the new
behavior is correct.  I'm CC'ing the SELinux and Reference Policy
lists so that the policy devs can take a look and see what impacts
there might be to the various public SELinux policies.  If this looks
like it may be a significant issue, we'll need to work around this
with a SELinux "policy capability" or some other compatibility
solution.

--=20
paul-moore.com

