Return-Path: <linux-kernel+bounces-826641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4712B8F055
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B833B571F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B518D636;
	Mon, 22 Sep 2025 05:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKrMn2iz"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806938F40
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758519160; cv=none; b=rUpoQWRx0Kdhzmh7rbJOyNrzXGhagsf8IqF8ISigHKC9K79UtT5kZc+wZLqTPrIyK4dNq9c0t+2Fc8p14cQgw5x5BV0Pk7hR7pNWyeHbczdKkheBJn7Pt/nKQo+ZtrMX8xQMx5+V26hTl298oVJxBGCE+8ljxLUks+Y6w6zNInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758519160; c=relaxed/simple;
	bh=MPqt8U2dGwSuNGBZEXOgyM8KTCH3a3xsi/toP8qpvFU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YpiCj2rYKuphK1FeKXSPhDIVw6SAlwtLm2gRQQbt8XfUWF/Pbzl7k4tERbwLFAQfeIt+jQfabIuoD8UD79qA6Zu8GHgwwrJCUfyIpEqODMeDmLGhN5YXi7GIQ139dPCDOvL92VTp8r0S94MNmUH+2+yrwPRqOppX83BXPJpqhhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKrMn2iz; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-749399349ddso9756097b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758519156; x=1759123956; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KHgPTIbjX+RbMxmT88/7XGBe+Iqw80rvF2C6MVvZKFM=;
        b=dKrMn2izZqPzqcEKsAfYDXN+QQIX4LcsGA4O6+NCtNU0duGRQB0V2FYgJIcO3HZmES
         FXSAK/4gLhTDn6HfeLTdOP5ojmNJAboFvovn1rOLdbmOPhbqaziO9es3PvweChmahC0f
         wqkbxY+q9R1+bcFiXcudybxSYq65HwtcBtuQoFNlAS+YA+/l5m7menrPvkSXIEW52QQk
         hqcnq9rE0X/Wm6XT7Svsd4YMWtU4mW1OzFie8DCmYiw0HFH7/880M7bNxzUpyG02GuZn
         QFIKPEi4HvZ7wvDyDnojqQZg6cVbs1r8YrQ1Iwf3FjAt+cscGxXgLJXK4f7HhGjU8hmc
         h+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758519156; x=1759123956;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHgPTIbjX+RbMxmT88/7XGBe+Iqw80rvF2C6MVvZKFM=;
        b=mT1zoyIN8wLfhb5lJ+HgByrt6yUoq4zzE0vkkKqW7VkBG1+3hHgGZ++mTo8rYshqX4
         tO9V7aXdlgvr77aEe59w84TNPg6sglkJjnMndoFu/CXOKnNK02w4iuGGEMJJdlq5NoGB
         eGb8LlwXmSACQ7sbmg/iZg9B0qv4krwDsYhIy621O0MKzfBARPoxHammkXhLSSsW3YcJ
         lZWnOgeA0oRb+OBS+86QFOiaK1u7PUevGtiAg/j/ejtje16QwrnFDU0/Zfezlt+RnWkR
         /sLQbVk2t+j9EUeIvb+Ok0IhAQ5x1ZL/tZDTytZC6oc4w/3wQ4/932WQKtYadPmr/gV5
         szpg==
X-Forwarded-Encrypted: i=1; AJvYcCVU82jJSj3ZHLZIRSGP0JY17IM9BzhVThgIKSAAC8WvVdgXZ1f93lu9Wk8+Gx6UHOiw6zO2b1+Vd4Ys8fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/0SlSMmPlrX7MZ1XQsA1RvtkhMcj9UPIopuor/6YMcTw4YTC
	NEpK/dPZmKV3QoMXDQLbBgAISmbD85zfuvoX+/E524xC3V8DgZpu4RLCIWwHCJDrUQ==
X-Gm-Gg: ASbGncul5zQC0k/KM41tFHU6Kgx7nhcrXIRFsxfHMV9aGsMQzSRX5z3Tm7lKv+PnL83
	DFPr1yb/t+jxYq2rWgoL9ObDpeuN2vX2hyZZBtT5MuSwOuJfUhBJc2wa6dwCxWw0GN/vnjViiCW
	C7U7xhOXl8Xcil9OJ+vHnwvTCRzqvgvhCFv3XZ+0kRa4xwWpVr1FqWApuW3T5amLfDjmSR+/sq+
	dq7uU57UOFK8jEr7gUT80hX7Dy9O3JmaoEMO+/atm8zdh+Vpqt8gk5g3MslyLNmC30P+MdpELyQ
	cbPFZ2FScWWTCI5RJi08plryvkw02Kx/4LS6E3ygdOSdoKGQeoccMNKyaHicpkSXkfv4cMcv6Iq
	I3X+CZqi7L6ufZgMioTqgFYlxq04+jvG/tY6i2gX5HuWfVIEY8cfWK5KdHfMdA+Fw9O47Lm2glL
	sZ6Zt86Fs=
X-Google-Smtp-Source: AGHT+IFzBltc4om+yBhRMAIvW/UzktP2uCRxkzi+JbnUMI7OkFia9Q0opJVxxbuhe9MhVRYr9y+xoA==
X-Received: by 2002:a05:690c:6403:b0:748:a797:38f4 with SMTP id 00721157ae682-748a7b5c11amr44113347b3.0.1758519156045;
        Sun, 21 Sep 2025 22:32:36 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739716bd8f2sm31249387b3.10.2025.09.21.22.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 22:32:35 -0700 (PDT)
Date: Sun, 21 Sep 2025 22:32:20 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
cc: Shakeel Butt <shakeel.butt@linux.dev>, 
    David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
    hannes@cmpxchg.org, mhocko@kernel.org, zhengqi.arch@bytedance.com, 
    lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
In-Reply-To: <787dc1a4-d0b7-4559-8160-55de987beac3@linux.alibaba.com>
Message-ID: <74e0af46-18a0-8c4a-5ae5-3cba69ca77bd@google.com>
References: <cover.1758166683.git.baolin.wang@linux.alibaba.com> <9ef0e560dc83650bc538eb5dcd1594e112c1369f.1758166683.git.baolin.wang@linux.alibaba.com> <17d1b293-e393-4989-a357-7eea74b3c805@redhat.com> <4e938fa1-c6ea-43fb-abbd-de514842a005@linux.alibaba.com>
 <tombfifwrhx2n4jnj2pgcdcpj42mdv7yizkpxrppnqrtsxd5fw@epnrjqgmmy6z> <787dc1a4-d0b7-4559-8160-55de987beac3@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-48439284-1758519154=:2993"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-48439284-1758519154=:2993
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 19 Sep 2025, Baolin Wang wrote:
> On 2025/9/19 09:06, Shakeel Butt wrote:
> > On Thu, Sep 18, 2025 at 05:36:17PM +0800, Baolin Wang wrote:
> >> On 2025/9/18 14:00, David Hildenbrand wrote:
> >>> On 18.09.25 05:46, Baolin Wang wrote:
=2E..
> >>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>>> index f1fc36729ddd..930add6d90ab 100644
> >>>> --- a/mm/vmscan.c
> >>>> +++ b/mm/vmscan.c
> >>>> @@ -701,16 +701,10 @@ static pageout_t pageout(struct folio *folio,
> >>>> struct address_space *mapping,
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PAGE_=
KEEP;
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!mapping) {
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Some data journa=
ling orphaned folios can have
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * folio->mapping =
=3D=3D NULL while being dirty with clean buffers.
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Is it still poss=
ible to have a dirty folio with
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a NULL mapping? =
I think not.
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>>
> >>> I would rephrase slightly (removing the "I think not"):
> >>>
> >>> /*
> >>>   =C2=A0* We should no longer have dirty folios with clean buffers an=
d a NULL
> >>>   =C2=A0* mapping. However, let's be careful for now.
> >>>   =C2=A0*/
> >>
> >> LGTM.
> >>
> >> Andrew, could you help squash these comments into this patch? Thanks.

(Myself, I would delete the comment entirely: it's justifying the change,
which is good history to go into the commit message, but not so good in
the final source. And we don't fully understand what to say here anyway.)

> >>
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (folio_test_private(f=
olio)) {
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (try_to_free_buffers(folio)) {
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 folio_clear_dirty(folio);
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("%s: orphaned folio\n", __func__);
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return PAGE_CLEAN;
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VM_WARN_ON_FOLIO(true, f=
olio);
> >=20
> > Unexpected but better to use VM_WARN_ON_ONCE_FOLIO here.
>=20
> Um, I don't think it makes much difference, because we should no longer h=
it
> this.

We do hit it.  Observe, there was no WARNING before in the !mapping
case, just a pr_info in a particular instance of the !mapping case.
We believe that instance went away with reiserfs, but that does not
imply that there are no more !mapping cases left.

We do hit that WARNING: not often, and I've not seen it repeatedly
(as ONCE-advisors fear), but a few cutdown examples from my testing
appended below.

I'm sure you'd like me to explain how it comes about: I did spend a
while looking to do so, but then found better things to do.  By all
means go in search of the explanation if it's worth your time: it
might indicate a bug somewhere; but more likely it's just a race
against code elsewhere cleaning up the folio.

The fact that it does not appear repeatedly suggests that the folio
is successfully dealt with afterwards.  I didn't think to check at
first, but in later runs did check back on such folios after, and
verified that they had moved on to being freed and reused, not leaked.

The examples I've seen have all been swapbacked, though that may
just reflect my tmpfs swapping load.  With mapping NULLed, there's
not much to go on: but index 0x7ff5ce103 is likely to have been
anon, and index 0xcff more likely to have been tmpfs.

My vote is simply to delete the warning (and the comment).

Hugh

[  206.559451] page:ffffea0000f6eb40 refcount:2 mapcount:0 mapping:00000000=
00000000 index:0x7ff5ce103 pfn:0x3dbad
[  206.577039] memcg:ffff888012358000
[  206.584624] flags: 0xffe000000020219(locked|uptodate|dirty|workingset|sw=
apbacked|node=3D0|zone=3D0|lastcpupid=3D0x7ff)
[  206.590603] raw: 0ffe000000020219 dead000000000100 dead000000000122 0000=
000000000000
[  206.597680] raw: 00000007ff5ce103 0000000000000000 00000002ffffffff ffff=
888012358000
[  206.604406] page dumped because: VM_WARN_ON_FOLIO(true)
[  206.617553] WARNING: CPU: 3 PID: 17918 at mm/vmscan.c:699 shrink_folio_l=
ist+0x87a/0xbb0
[  206.623211] CPU: 3 UID: 1000 PID: 17918 Comm: fixdep Not tainted 6.17.0-=
rc4-m19 #3 PREEMPT(full)=20
[  206.634664] RIP: 0010:shrink_folio_list+0x87a/0xbb0

[ 2023.016300] page:ffffea0000d2f640 refcount:2 mapcount:0 mapping:00000000=
00000000 index:0x7f5c34549 pfn:0x34bd9
[ 2023.031613] memcg:ffff888012358000
[ 2023.049601] flags: 0xffe000000020019(locked|uptodate|dirty|swapbacked|no=
de=3D0|zone=3D0|lastcpupid=3D0x7ff)
[ 2023.059626] raw: 0ffe000000020019 dead000000000100 dead000000000122 0000=
000000000000
[ 2023.073965] raw: 00000007f5c34549 0000000000000000 00000002ffffffff ffff=
888012358000
[ 2023.091613] page dumped because: VM_WARN_ON_FOLIO(true)
[ 2023.111727] WARNING: CPU: 4 PID: 30543 at mm/vmscan.c:699 shrink_folio_l=
ist+0x87a/0xbb0
[ 2023.111749] CPU: 4 UID: 1000 PID: 30543 Comm: cc1 Tainted: G        W   =
        6.17.0-rc4-m19 #3 PREEMPT(full)=20
[ 2023.111761] RIP: 0010:shrink_folio_list+0x87a/0xbb0

[ 7604.465422] page:ffffea000092c480 refcount:2 mapcount:0 mapping:00000000=
00000000 index:0xcff pfn:0x24b12
[ 7604.488416] memcg:ffff888015410000
[ 7604.506284] flags: 0xffe000000020019(locked|uptodate|dirty|swapbacked|no=
de=3D0|zone=3D0|lastcpupid=3D0x7ff)
[ 7604.528118] raw: 0ffe000000020019 dead000000000100 dead000000000122 0000=
000000000000
[ 7604.564338] raw: 0000000000000cff 0000000000000000 00000002ffffffff ffff=
888015410000
[ 7604.564790] page dumped because: VM_WARN_ON_FOLIO(true)
[ 7604.564822] WARNING: CPU: 5 PID: 78 at mm/vmscan.c:699 shrink_folio_list=
+0x87a/0xbb0
[ 7604.564852] CPU: 5 UID: 0 PID: 78 Comm: kswapd0 Not tainted 6.17.0-rc4-m=
19 #4 PREEMPT(full)=20
[ 7604.564871] RIP: 0010:shrink_folio_list+0x87a/0xbb0
---1463770367-48439284-1758519154=:2993--

