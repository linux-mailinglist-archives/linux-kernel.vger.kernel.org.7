Return-Path: <linux-kernel+bounces-727026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF79B01417
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E05D1CA04F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610741E51FA;
	Fri, 11 Jul 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBZNiG+t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABEA1E32A2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217757; cv=none; b=iaXW7d1h65Nl5J1BplD/PYdaAs77tOlVbYZ0r+0N5qJZDoEnhLu7H2lMBDmkhAzoIKAnYbI1iVXEwVkf60Cw7NBuehuTOWjOtQHVfzKf16O3f94BEl1QGcV8+daQocyfAxs3zVnB/0Q8sWXrF1qRxe0L5CTpeMqbboITalAsPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217757; c=relaxed/simple;
	bh=bETnLwmqaijMFkik+F4Wsz2XGYFd+5UAIq5aNY2jDXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ounU/5+fxFTUV73YpowdzmZgrfdz6kOZmF269MYdJA73O+2rldzcM6uDr3YLFUDIMQctuTPB53B74Yv6nzew2SdSQpuxNEMR5YvDm0D3gy1o66kJjuNpKZhQEsesLq08NouuqZ3UTOwweccyuumKdMAVye+ENmNZgWVxMeycIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBZNiG+t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752217754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Tjn8ea09hAYyGZY05rFnfwzbxRm2j2QdgLyEwncWfLM=;
	b=VBZNiG+tOJTORqmU+oeEOUMtoFBDqK/hS3ZXpMR4BMuikR5qEFHCLJ2YoJFUOUEwBkoVrK
	4RIXH3ZJvhorcbNaif+09So4Vna79PmF3emoMQSzEzXpUkeLnIFqRHzyTVlrTdYwY8mEvb
	FXNNBgpvaUBfpjQ2gIIFGI9GHrQIu7w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-y4dJP22aMaOMle_KCA3qtQ-1; Fri, 11 Jul 2025 03:09:12 -0400
X-MC-Unique: y4dJP22aMaOMle_KCA3qtQ-1
X-Mimecast-MFC-AGG-ID: y4dJP22aMaOMle_KCA3qtQ_1752217751
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso10137295e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752217751; x=1752822551;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tjn8ea09hAYyGZY05rFnfwzbxRm2j2QdgLyEwncWfLM=;
        b=C0yzZISIKr4gb7Nf68yk1tcsz+ITux6pv3qEB/rHNOtHszya9eIPURRyDXEecWW8fM
         K7CY/TWE0+NYB+I3Ye12AIibQtkZrXBTQRWAm/oH+zSNYwJR/DsQLz2xrzFWg8N2bc4h
         PcsFvIe/gZvuxo1a4Rf6rCfuVIjQFEKUbRo+LcD7eRDP1ADhrf5QH/ctBXInjUEqCxZ6
         mZWFEa69HDjKux5p/6EdrkdlqsSzaF44znux4X/xL5vZjVERftJylIyrUW5sV5EhDNvM
         80UlF2NV7dOMRV47RYO+jcwN8mfSp68DS00ZRDZcKloLn24tSNXBl8WF7pPNaFpEmIwh
         yYBg==
X-Forwarded-Encrypted: i=1; AJvYcCVfwQS6ov8b0J2yv69QqtbuzUEHpFlmfGh/Pbo3BemumsGWllSlbqKwito2VDKdg+w6W2aPnHQ4lre8d4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxruvaaBqhxxbvS2lJ4cwGW1q7KmroXU2hZ0hAM9cL0cDM3lbeD
	8K37Gk6cyNhKLgYD1UUVixhc8DitbHStbP+57gNA6JzW0gfb5rdnQdIYzEM+hr6CDx352tygx0g
	stygHTlsl6xyPNXvJu/p52r+Hzv+5jJnM+lvfAuXCBlMcYuaeGcZm9icdTD4fEhBSdg==
X-Gm-Gg: ASbGncvkHFDTkQL1iOD7MRaAA4wypit5NLknYtN9DlNurRVcVhVg4d6w1qKxqyn+zt/
	WTjoP6NrKhU4EAEbTpzu1gICt8vz25Kw9A41H8WZ12yzpL1pW3jsJvP2xyMp5I1A1kW8V6gIosR
	/IkBee/+CUt7BkkJ0wfrWia3tsfPotGjQT7Y4RSR5vnt6ol1cbVHIzICkQ1wu1UI+0X/upClqVz
	Bqu5CPk9SuycOE61iVjKM+96R4uxWAJR/AoFS20NZzJbwyKrGXs70V/68lyyrcs7qbuFuJNdg2l
	xy8Rm4zak8pNu7uG227VSyjdpPH2bg5D/WNfer0Q3yScPm89UvFuLYdhoaJLlsHtnH6+WlFoXRa
	SPrQe
X-Received: by 2002:a05:600c:1e02:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-454e2a426afmr18492685e9.0.1752217750990;
        Fri, 11 Jul 2025 00:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyLKqZyYTcKdieu4HXWBw9vMWmwczdsUxrQjWlMbBHxItodaJAHPJRLciB88X4EIKhTPKSpQ==
X-Received: by 2002:a05:600c:1e02:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-454e2a426afmr18492375e9.0.1752217750577;
        Fri, 11 Jul 2025 00:09:10 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-149.pools.arcor-ip.net. [47.64.115.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd4660c5sm38083405e9.11.2025.07.11.00.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 00:09:10 -0700 (PDT)
Message-ID: <9f7242e8-1082-4a5d-bb6e-a80106d1b1f9@redhat.com>
Date: Fri, 11 Jul 2025 09:09:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc: Replace the obsolete address of the FSF
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-spdx@vger.kernel.org
References: <20250711053509.194751-1-thuth@redhat.com>
 <2025071125-talon-clammy-4971@gregkh>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2025071125-talon-clammy-4971@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2025 07.52, Greg Kroah-Hartman wrote:
> On Fri, Jul 11, 2025 at 07:35:09AM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The FSF does not reside in the Franklin street anymore. Let's update
>> the address with the link to their website, as suggested in the latest
>> revision of the GPL-2.0 license.
>> (See https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt for example)
>>
>> Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v2: Resend with CC: linux-spdx@vger.kernel.org as suggested here:
>>       https://lore.kernel.org/linuxppc-dev/e5de8010-5663-47f4-a2f0-87fd88230925@csgroup.eu
>>       
>>   arch/powerpc/boot/crtsavres.S            | 5 ++---
>>   arch/powerpc/include/uapi/asm/eeh.h      | 5 ++---
>>   arch/powerpc/include/uapi/asm/kvm.h      | 5 ++---
>>   arch/powerpc/include/uapi/asm/kvm_para.h | 5 ++---
>>   arch/powerpc/include/uapi/asm/ps3fb.h    | 3 +--
>>   arch/powerpc/lib/crtsavres.S             | 5 ++---
>>   arch/powerpc/xmon/ppc.h                  | 5 +++--
>>   7 files changed, 14 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/crtsavres.S b/arch/powerpc/boot/crtsavres.S
>> index 085fb2b9a8b89..a710a49a5dbca 100644
>> --- a/arch/powerpc/boot/crtsavres.S
>> +++ b/arch/powerpc/boot/crtsavres.S
>> @@ -26,9 +26,8 @@
>>    * General Public License for more details.
>>    *
>>    * You should have received a copy of the GNU General Public License
>> - * along with this program; see the file COPYING.  If not, write to
>> - * the Free Software Foundation, 51 Franklin Street, Fifth Floor,
>> - * Boston, MA 02110-1301, USA.
>> + * along with this program; see the file COPYING.  If not, see
>> + * <https://www.gnu.org/licenses/>.
>>    *
>>    *    As a special exception, if you link this library with files
>>    *    compiled with GCC to produce an executable, this does not cause
> 
> Please just drop all the "boilerplate" license text from these files,
> and use the proper SPDX line at the top of them instead.  That is the
> overall goal for all kernel files.

Ok, I can do that for the header files ... not quite sure about the *.S 
files though since they contain some additional text about exceptions.
I'll drop those *.S files from the next version of the patch, I think these 
likely need to be discussed separately.

  Thomas


