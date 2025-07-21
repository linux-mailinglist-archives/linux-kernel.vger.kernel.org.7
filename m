Return-Path: <linux-kernel+bounces-738908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E99B0BEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404DB17D064
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA68287258;
	Mon, 21 Jul 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xsyUQ/tH"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2B21C190
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086440; cv=none; b=eGEXvp/14bSBkXWAGaRVo9clv80dp2YoQwpNF+Dj5oAv4O4Kjk56zJc2i+/c77wLz31OG5dGnc1fM0XIoqUYnmCmvevnOmuqnt7mMsHLgKOljs9KOEIwAxhmwR0xHWNV8axu3N1f+sD5e3IR/9qi9Ino2S/PXGprXACKOclNeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086440; c=relaxed/simple;
	bh=RBv9fk0/5szEH5fYfYL9K4i2DawNtHAPuulxFPKeGbM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=AxQkADjLrpJyJT/AbOXr5lmTpjN79v6EipndM2hswnBzuTuAxvjqpcGawetjby2A9ERqFT+s8l03b48W+pupY56Tcu/wFrZGNTgRuryCTchblC5eE79jASsW6CE97p9U5/ul7fICgh3aqox3yMqPwNNIHsMnyxyenaUFdXFOB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=xsyUQ/tH; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e278d8345aso401834885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 01:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1753086436; x=1753691236; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/odcKAEmFXyMNrSMxdYfCowLIbfS48TF5S5CI5CnjPI=;
        b=xsyUQ/tHpmQ+w8j4LsYZc9tWL8UFrY0SkT/OE496+4vP4BnkT7Tx1lcaXyz8n8yjwc
         pZzngMGr1HUkLf96essJ5IdBVEAf+N1bsnux0CWNWYKKgDLYBweqNQldBCWHlh0Btda3
         6g+dCKgyFT7xY3T3AlR4cp7q8j3hYlfNH9Y7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753086436; x=1753691236;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/odcKAEmFXyMNrSMxdYfCowLIbfS48TF5S5CI5CnjPI=;
        b=HL8GbUlLajLEkdVytmGYwj6oqgqOQOm4BWzZqj9+U3YaQJPmao6ruFAuuKKYZ4YZJG
         q2EpzwGKWcpr6GYjs8vOB8fFCmUtlC7VcoVLB8GCZXX9t85b+lFvvoo16oQZTxM5cwjm
         Xd5LtznGuakYYXgzXdh/Jx5dLKkcMkrrWayaLZ7hvntGEPFv0lnJKGS8b9HH8nmj8nvM
         qzGwUijo2LyjakO8SJHLxOvpiJwqKrvDrDERG3ZsjG9FdJC2Ic8AHwqhReSFc6HpKMvD
         QQGCbysUcAnZJ/rlewXoGA+L2fjbcOpfk7hxPGbHbBENC6OJZ6lSzYju0wYSfMZzlHe5
         Y/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUlK39tH31JijE4JqZttvzXycgHLdQ4oRP/sucscPg2uS7CemGTAyabeEy/4QwbEJPl56CRIWYr1AiKwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3kDsC48WsyjYryXzSlbPYQ7YLBxx5wXIDTr/CSkPdcyMVIyw
	Rdv0e6RbN6//yiM0K26IbUMRzoDaEZoCgYAhNVqmL+UfI7EPnvPIiPAYHIHvJ9b4j8sdUoVIm3h
	NeAIQ
X-Gm-Gg: ASbGncsrvr52W5cEG5Dhqzib/ea4WseK45htoHb2bFec9v700DlKwcH2HIOqfXND5+f
	8RYJdJjM9BvrB3T8XznlCSTf4b7+ukBCZRWRUm78DQt1eoj68/VkzPfdM5fDijL7p444CxDzbn4
	uZjB7mLN7F0TOdecAHwbwvEb+PYnmRCCAjr+b/W7Vbh/m+jsfBI2DDSFyX1iYeLqbO/SnXsyoQt
	bNHxiVlNx5bQ/c/N3SNLLbw3tZ7zJoqWnGff7ms1DTAuSWiLp7/Sx41GGu2ytwq6Ej/ZOByIY7x
	nhhPpR/ljas/78m6vRDcoELfRQt99lyxEm3yIpgMjVJnu0gePEfNP+I0nY9dCvqiD9QPE8xORFE
	ljymaP/qtgq3tDKLQN1AUhNvQ2hNHzworggLD2iVA653ptdGYghqS
X-Google-Smtp-Source: AGHT+IHbpPzBeQV8pR+BUFeuByOVOFSZa2i1bRfXbW08DvV0AlP+I06Rjyv/ga6t1AC/b/OjAPmsuw==
X-Received: by 2002:a05:620a:46a6:b0:7e1:5efc:6f6 with SMTP id af79cd13be357-7e343633b0bmr2801006985a.47.1753086436100;
        Mon, 21 Jul 2025 01:27:16 -0700 (PDT)
Received: from smtpclient.apple ([71.51.186.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c3eb74sm390618985a.62.2025.07.21.01.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 01:27:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next 0/6] Patches for v6.17
Date: Mon, 21 Jul 2025 04:27:04 -0400
Message-Id: <A85925F6-3F1D-4D7A-9345-7E20512ADB21@joelfernandes.org>
References: <CAFwiDX9K8T4uDRCmp3R+TqBaKO_jtXwcaeFYdpg-9C5MVJAo4Q@mail.gmail.com>
Cc: Akira Yokosawa <akiyks@gmail.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 paulmck@kernel.org, rcu@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>
In-Reply-To: <CAFwiDX9K8T4uDRCmp3R+TqBaKO_jtXwcaeFYdpg-9C5MVJAo4Q@mail.gmail.com>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
X-Mailer: iPhone Mail (22F76)



> On Jul 21, 2025, at 12:29=E2=80=AFAM, Neeraj upadhyay <neeraj.iitr10@gmail=
.com> wrote:
>=20
> =EF=BB=BFHi,
>=20
> On Sun, Jul 20, 2025 at 10:01=E2=80=AFAM Akira Yokosawa <akiyks@gmail.com>=
 wrote:
>=20
> ...
>=20
>> There seems to be a couple of issues in the S-O-B chains of commits liste=
d
>> below (in rcu/next):
>>=20
>> * dcf1668449c9 ("rcu: Document GP init vs hotplug-scan ordering requireme=
nts")
>> * bb1c373934db ("rcu: Document concurrent quiescent state reporting for o=
ffline CPUs")
>>=20
>> They have a "Co-developed-by:" tag without a corresponding "Signed-off-by=
:"
>> tag [1].
>>=20
>> Or, if the contribution is too minor to have a "Signed-off-by:",
>> then a "Suggested-by:" tag with a "Link:" to the relevant message should
>> suffice.
>>=20
>> I have no idea which approach suits better in each commit above.
>>=20
>> [1]: Documentation/process/submitting-patches.rst
>>     section "When to use Acked-by:, Cc:, and Co-developed-by:"
>>=20
>=20
> Thanks for reviewing this! I will fix the tags.
>=20
>=20
>> Quoting relevant paragraph:
>>=20
>>  Co-developed-by: states that the patch was co-created by multiple develo=
pers;
>>  it is used to give attribution to co-authors (in addition to the author
>>  attributed by the From: tag) when several people work on a single patch.=
  Since
>>  Co-developed-by: denotes authorship, every Co-developed-by: must be imme=
diately
>>  followed by a Signed-off-by: of the associated co-author.  Standard sign=
-off
>>  procedure applies, i.e. the ordering of Signed-off-by: tags should refle=
ct the
>>  chronological history of the patch insofar as possible, regardless of wh=
ether
>>  the author is attributed via From: or Co-developed-by:.  Notably, the la=
st
>>  Signed-off-by: must always be that of the developer submitting the patch=
.
>>=20
>> Side note:
>>  scripts/checkpatch.pl would have complained about those missing
>>  Signed-off-by: tags.
>>=20
>>>=20
>>> .../Data-Structures/Data-Structures.rst       |  32 +++++
>>> .../RCU/Design/Requirements/Requirements.rst  | 128 ++++++++++++++++++
>>=20
>> I'm seeing sub-optimal uses of reST markups in Requirements.rst from kern=
el
>> documentation stand point.
>>=20
>> I'm going to submit a patch or two to improve them, but I can't promise w=
hen.
>> They will likely be only cosmetic cleanups and I'm OK with it upstreamed a=
s
>> it is.
>>=20
>=20
> Thanks!

Thanks, I appreciate that!

- Joel

>=20
>=20
> - Neeraj

