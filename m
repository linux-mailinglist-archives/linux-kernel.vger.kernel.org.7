Return-Path: <linux-kernel+bounces-861176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2797BF1FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3727E18A7659
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E1223DD0;
	Mon, 20 Oct 2025 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHFJQdad"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4AEEEBA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972746; cv=none; b=ebT8bUVLtpv7JfR6zWy3Bn+X54lAAR/INd8GW0EIQRA2XVjwDIZuJBlXYk5Gx7LDF/B/VII0YcF/PzjY3+AEr7HIUDl+p/X9Md4EFg3xcoi4InHURO7Cxut1buLKKH0glXoJkITO9pdxuzfdJlSV6b0kqZeILwtgLkoXmK/dJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972746; c=relaxed/simple;
	bh=l7dkSlMrM4uNz1uQ47rux78d4oGi2GhW8UQz6473KPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FveYXuH7AERF7bm95QlP+vE0d5PbfgUekvwW6N52np/cZFaN9Fk5J7/gjdETDpm7kCDBRspyPDqh0feMxGBg6kdysW1utd++K5oJ8EuktL8XGwqwNBum00WjXhkiQGBCyDFbQWDOeS2OQaTnCbhK2AMNE6jeJW751Urqu2+puGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHFJQdad; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760972743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UoysR2dfgelM8ATLc2CIop8Abv9DjCmPw9q8A2JxxaE=;
	b=AHFJQdad1FNmmDYfEyJ/90BIApDZF2IIPWX8gSQxneRys55XYNfd9btGfEj+1ueFN0Bpw9
	onksvCp6735sidkmSqpzKnagNRUm7/ROjuswJSCBt7xBObNShUhezX/6fUC2F1s73WxVu+
	BeV5Ifrhfw18Qqd0X3rgyJCYdsR7FqA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-sxTGIJDBO0aUHIFSiFcLbA-1; Mon, 20 Oct 2025 11:05:42 -0400
X-MC-Unique: sxTGIJDBO0aUHIFSiFcLbA-1
X-Mimecast-MFC-AGG-ID: sxTGIJDBO0aUHIFSiFcLbA_1760972740
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47113538d8cso24692495e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760972740; x=1761577540;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoysR2dfgelM8ATLc2CIop8Abv9DjCmPw9q8A2JxxaE=;
        b=RzBgpKJSJoeOLZhZJ0Lhu2hlSSxrMkUrwxibXxp5gLDO88qYHcHQ1UJWBPC7W6UvgB
         fdQd/c81h/jk0WP8S9P7eKh72BpxpfTuYX0It83nrRBDOmG3wuE3FMAisHKCTDnnRok/
         VJuxFgyh2ZqonFo/9U4JK6528KOggMcMDNs+AGWfhpoAYCrNso0U81vgWRKou4swOP5N
         FOXsMhgztenT5CMFg2eMfa1f1V83QTF+GDdoaLkExN0dWCSXP+wnVlzjBsVzUCJKOQmG
         VcfQv+BnMiz8r0gzPuiD61F4Im3km72wA9d00FGwvNWDzZqm8jDNH7MradMUpruE0eCf
         n37g==
X-Forwarded-Encrypted: i=1; AJvYcCWr7ErONN/ye+tGZIDXBSGINCuosFD7tnigfN950l5Lt2vcUQTwik1phuAE/gLGq08VERlPMLcpcKiRgcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FBS0hJs42buWRFNLY8xUTHvetNPZMhCcy1SU3f5CCqRnInj7
	2vZ4AOJxJItCyv+xiRssWuQ7ueY823yJfjl8Wu0LhgaLdg6hV0fktuDVyEF96RKA+b/MbKl/HjP
	IwmCYb075PvfoSJxubvscndLkkhHIUKwRurB6eVF3SSPYqhI2Qi1X/QYkPf4o9c0M3A==
X-Gm-Gg: ASbGncs6dgcjbx+fRDCFAl2Dsc166xgPDLL80p4JM2RJ0055c7yudi23F/gQvJEzn4z
	ChKN/jG3NDbQnPasp2mRLaQL6lQTfyZzd0qBlu7LMDYdv112sv3hWUbYBSUKGGh4ubPSyq493FF
	ZmgzHJ0SjDRuORdpTLK5zwVy/9e1IFSPRnwK3YDBEks119/95wTRZJa1kLZm0X0fF5EVKfrXvTk
	o3ZITUxrzWvffvF0ESRaqpBN1JX7vEITLAaH2tCCCUEsEZB0LnfSyZ6Si1yUhUmNFLvDNvWQNfb
	IesyxkOdgkAflbWWJouc+to8yiDnK1GSVnsi7lEYuSsy3UATxt2plZ4ACetedqqgWcK3bI0gR0O
	IWr1dkNlOomzsuUMXjNkEfSKi6CZ1ydD9Gyz2v+5Ff158vL1V/2pOGFEbq0LPXQa9wBJan849xt
	V7ew==
X-Received: by 2002:a05:600c:548c:b0:468:9e79:bee0 with SMTP id 5b1f17b1804b1-471177bc126mr93667955e9.0.1760972740502;
        Mon, 20 Oct 2025 08:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/OQhxSYFv83q9Vf5Py7culoO2ecRKhVrom0FLqX6Ye00kYF5psp1cT3TotftVkvxc4hvwLg==
X-Received: by 2002:a05:600c:548c:b0:468:9e79:bee0 with SMTP id 5b1f17b1804b1-471177bc126mr93667645e9.0.1760972740118;
        Mon, 20 Oct 2025 08:05:40 -0700 (PDT)
Received: from [192.168.10.27] ([151.61.22.175])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4710ed4b47fsm117263495e9.4.2025.10.20.08.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:05:39 -0700 (PDT)
Message-ID: <cfc43786-5a9d-4813-b8ac-a8a55f430f03@redhat.com>
Date: Mon, 20 Oct 2025 17:05:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] paravirt CPUs and push task for less vCPU
 preemption
To: Sean Christopherson <seanjc@google.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
 maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org,
 vschneid@redhat.com, iii@linux.ibm.com, huschle@linux.ibm.com,
 rostedt@goodmis.org, dietmar.eggemann@arm.com, vineeth@bitbyteword.org,
 jgross@suse.com
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <aPZIGCFk-Rnlc1yT@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <aPZIGCFk-Rnlc1yT@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 16:32, Sean Christopherson wrote:
>   : Till the hint from underlying hypervisor arrives, another idea is to
>   : approximate the hint from steal time.

I think this is the first thing to look at.

Perhaps single_task_running() can be exposed in the x86 steal time data 
structure, and in fact even in the rseq data for non-VM usecases?  This 
is not specific to VMs and I'd like the steal time implementation to 
follow the footsteps of rseq rather than the opposite.

Paolo


