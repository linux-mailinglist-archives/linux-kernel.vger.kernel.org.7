Return-Path: <linux-kernel+bounces-848454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16A5BCDCF5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37440544E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1992F7AD6;
	Fri, 10 Oct 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XAaBD7XZ"
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E67236453
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110404; cv=none; b=BS0iee0zqk1G5RVkQAOvoBk02Kqwk8n3rSO9G/GUsRBkZ6VtH4no9FXiRTTTyWiBTFVad/nzFskQFF5eV/VBULUZsNPobCqnw1GigAdnJ2gQ3WyXTG6sHceLQ2dTA7NExxeo35F2i1ga6uPipN0SNnAkxdYHiAAdQx0L6n/anCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110404; c=relaxed/simple;
	bh=EKFfg6RALBfqbr/dYy/1ZIEa31ZTm+KH8h51c1P/c8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PX/6rOKSRZ5CcjGyu4dqHt8m3uG/cOgNY00GhHfYOW0YNn3tmLStErl+ImkdyeZG3LZqFg/cq9xtOvlPSGG4gWsUViWoypwOq4cXQy0x9YZlvm/EVfj/b/6JOB1frZMOQXq5Yj654/Si1rXDUk6ty6UXPntAKH8QsTT7TNGf6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XAaBD7XZ; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760110402; bh=exrgRP9yWskewPDovuD1lx7An8iyLfpIqXKSg/23pHE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XAaBD7XZ+iB2YhtxqJmVrTPOyrfvEIiN1DQYVqhc96a/LwUV3ipG/cYx1ySEaDf1Mv6G4LpWXB3dSr5HTX7pn1FOaM3fDKjATHYHcEA+vsGP4pRpv9xaXoZb/2Gncn3wzDDEkqCquVRQbVpVzEJpyy6IjoaicuNsRxNzOy9K0Ujn2jqSDCmnfIyP9snpnkQL603LxaOkbvdt0QsxNrzUNC7sMBsqJeqs4SWJdQ/q59uCsHp9wBMg73WsMXtueAR6izXLmXPAdGpK4WU0f8ECvEmRPkYWPztvQalVi0iEbDFPFV3IUBwIxgPJWVXrXvrWnptROKQs1fIQoxVYjigBAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760110402; bh=6koR3bTNp4b7wqNogWRG3GgC3pe4N1BkVzn/lYGOLHU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=G29+Ec9d5XYsXBr/nVFC8ABIM2L2SwrFGSGrQjkSWjFvKB2aDNq2KGauL7j1EZPvQEYKLT7X4I2GBIoNZmt8IKx+NT3gwWbUoi0j5EaSH7zhabVYsMckGbcmPkwLEqNzSbiYvf6PVWgZ30hCf09xJBzcO2XvOZiftCIDncpsmaf7ede0u/vUnlrUN5d6opy8rtJbBfxcaobgYIgnK9OrbmJTsC1oy6UAp6MK32WtMfRfWLtKn/kbYQjN3gNy7BLZtLrFCsIzab+yYGrzijwNIcxzHKBkTcDxyi+DNwEaL6hcxw9Z6B/nFe7Ag1i2GeZENmdnTu4fQLzwDtwZW4s66A==
X-YMail-OSG: cL6KtFIVM1lfXtt4bQRphpWwax46JcSjKDBVNRw7150Q2IEsl6EeK3PNbUrDr4Y
 satb4yJU91XLAq7bIoph.1AdhGYp2S2xdn8WPutZrU.U4dmPijAQFFCD39JSoIDniRKKAs1WnSV0
 EgKHs6BdardFMlP.787mCnS.huVn6uDkX9PeIrMcg4jPPPhiQQeOl826g8ll1eJtEEjjgnJmIzZ.
 MQEvEDPlYDlPH.eAsIVUIpWfTcKVjpW_nPYK9i3msRE4xPyg0tu5eVMfzhVXl9IP_5vQMX9.JO5V
 310PLTQJ759aZnOmG1RmJ7_wrYQ_8H0xRw57o_QGdZ2UknuL2jRHcrlz6k6lIH3b.hgqaEPVG8MF
 .rVx5CkuHcI8BlYxLlXPkvajCPIIJcNqWamggEhc8DuHL0qAKfWjju9xg.ltHwLMjN7aElNyXo0d
 .evxmutbrNZB9KNSMWqzR_U.0dGB5cTkdxU1HeofNVZPamchyVGSkHKonAw4MnoUAQpui6ICbej8
 aRpl54mx1UevFxAKyzDcu8R2SgqaQnT8cfJlplsnM3tX7wnqYgxLBV08m3Nx4nMH1xPbGFRhExTb
 SKHaYWo0hThfkHttMbTOHbb.4MQxpYvnymXlytRDJ43vo8QGW.iokW.Ag.0sMwK6vp8reLk_wjkf
 y_D8r_6puIbXk3r_UO4SthoynJu34H7QqbrerK_QQW2MOKTZX90AHPwuqIVgfYgyRvxiebqOQpYC
 05lhWN9ggyh8LqrhXmsO3jFrblidcla8On5czSMW2zzFnMP5N5kMzdKgO7SA0hbXx78i_pimOLCK
 2L8QP9fWfgN5UJvkBWLmEflw.msJorifLpJEe20461QYmjgkn1ncc.SRvf2TT8Xe5Id1VjEXdzuX
 Q1_kDsfQr9E0iK5CtqJmteFH0FulluEZzNijSWMjGcrZf0cRO523M0CCuHYsXLKopOOMPteq6q.6
 NctEIPY2skiV0Piz_Xl1YFz82VeiJrdxWAX11b_5mSiPza.d9XAKtAzCP8TY.nWiM93Lf4WYCPmp
 arr_2iyiGHmOz3S6OWC4o_2QD9z7UXMpHgjOHtoYkkozeq.SfJYDSsYhSUb7CNC72iC0XjgTYmlA
 3Hgzxti_vfe0p2LJeUjURLqzBJZA7ppkBIOvsSxBR3NaomNkJ3ZilG18VmQzUiwp.ZPJfLkplHcw
 fAFVx9cEaE70984khDEIJaen_VMkxkcNhtGhdOJZlN6O.XOPMkl18oIhIeeUS3CfyxDE1jCg.D4h
 x_.wNjuPdLGaA711bUryLV_ojFglT1L8eXYfRzCCLUDO_ywweGP93HSeVzrZIEx0D1ME6Qpo1lKz
 sJSZBMLH0EWl65DWCpA52E5R1vgA_Y2sMOT9aidJnmlhCZOfLJk3W5PFKFCgKkGPfPm6l1TvDgzT
 68W.sH02cCgRPkD5H5CjPDaLudbfZvn.CHRoJsL4BWcih4xLmM1e0gQ6N7fEcrmgQkSvYs5WdMUB
 OYTiugAHvH5uplA6Zg_cWSNdeNMffABRMJPjfJdyqMS.yMNX0uG.d7Rt6Sf.8eVtqMxZuNHv0rQ2
 2801kOARMNWtTFw4l0PsOXFLRgAp3kt1OuZL0xYL0b2kNSF5eSyVWNERfgOwsqGTmdahu2bFG8oG
 isKQjRl_6Loii_tx9q_eItXPSBDaeL61WDv7RLT2x8XqCSWZVphIo_U44XK0wSvqg3tRz4kL1UF_
 n.E3dc_ZbkOTdPVhRRS4MhZX47qB9nZFxZHKgM21ZLwUfcvNSDj2GQkA5e4liStiL6LwJiHN7Wce
 pBpRtgIcbfdoAY74YJxQq0RKAizFiiLS2Flp.RxNMy1yoPLxMqYIQOp6eLvpbexNDIvhE4cjnfuW
 PBufTDP6T7m.b2hoXY9YAGEHaABdDgBUk8nSmFXGNLMuJPFmSsIQc4ito0_KEnPlHvfNQzSFgWvp
 R4bcsd1hKzDkf3SUjXnptu7Fk.6oq8oOtApqCMvOcl2MmCx4nF7bQkBGPhZ70OZ1.iSoO5T36HLN
 tOGreDfRuOQQF.oQ9jwP8y_z9ytkcQxobaJqpvmPfmDqYSE2xs0jQ.a1JH3KyqYvZptT9In7I5_t
 5v1aSP1a_V_kd2xahC41z.5hkJq8se8CuWVOCXyMvVEwWsC80PljX.FHKy5KM_HkuWy6hvrYtiE_
 DRjs3Rg5FOVPF38fZvRQJARI_Bo43maGPPTduSb4LQOpZjGL5FlctGsargLEfEXcLxx5Ra3R0ZwI
 ZqG2cyQ0EwckNYADa98f1IZzNMvjOAKmxS5taEpUz_3fHQJ_rmNXjDK5DvarYZcD1cvy4Q9YEBrK
 1GiLkSL0VMlCMSnLH.T49ZHxdwWrM
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a8bafbc6-6119-4f04-80f2-7829a02a7d6e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 Oct 2025 15:33:22 +0000
Received: by hermes--production-gq1-66b66ffd5-n7h9b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b69b2cbeeb508b65cf4776c6565eee92;
          Fri, 10 Oct 2025 15:02:57 +0000 (UTC)
Message-ID: <d091c8f1-798e-4b58-bed4-5f71478373c4@schaufler-ca.com>
Date: Fri, 10 Oct 2025 08:02:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] LSM: Exclusive secmark usage
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org,
 jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-2-casey@schaufler-ca.com>
 <CAEjxPJ7M4qySg+ZMujTqMQFSncWNbG21W+kpLzji6c4F+hyprA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ7M4qySg+ZMujTqMQFSncWNbG21W+kpLzji6c4F+hyprA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24562 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 10/9/2025 11:49 AM, Stephen Smalley wrote:
> On Wed, Oct 1, 2025 at 5:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> The network secmark can only be used by one security module
>> at a time. Establish mechanism to identify to security modules
> a mechanism to inform security modules?
>
>> whether they have access to the secmark. SELinux already
>> incorparates mechanism, but it has to be added to Smack and
> incorporates
>
>> AppArmor.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h        |  1 +
>>  security/apparmor/include/net.h  |  5 +++++
>>  security/apparmor/lsm.c          |  7 ++++---
>>  security/security.c              |  6 ++++++
>>  security/selinux/hooks.c         |  4 +++-
>>  security/smack/smack.h           |  5 +++++
>>  security/smack/smack_lsm.c       |  3 ++-
>>  security/smack/smack_netfilter.c | 10 ++++++++--
>>  8 files changed, 34 insertions(+), 7 deletions(-)
>>
>> diff --git a/security/security.c b/security/security.c
>> index ad163f06bf7a..e59e3d403de6 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -283,6 +283,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>>         lsm_set_blob_size(&needed->lbs_xattr_count,
>>                           &blob_sizes.lbs_xattr_count);
>>         lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
>> +       if (needed->lbs_secmark) {
>> +               if (blob_sizes.lbs_secmark)
>> +                       needed->lbs_secmark = false;
>> +               else
>> +                       blob_sizes.lbs_secmark = true;
>> +       }
> So if I understand correctly, the first LSM to register with
> lbs_secmark set wins.
> Not sure that's a great idea - seemingly some LSMs may want to insist
> that they get to use secmark regardless of registration order?

But what if two LSMs insist on getting the secmark? The whole point
is to make it possible to use multiple LSMs that what the feature at
the same time. The limitation on a secmark being a u32 is a huge problem,
and Paul has battled with the netdev people over it for years.


