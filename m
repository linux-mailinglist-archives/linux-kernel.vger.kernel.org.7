Return-Path: <linux-kernel+bounces-835611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26B3BA7974
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 01:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C70E1735DE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE642288500;
	Sun, 28 Sep 2025 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNfdX1Ri"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703325BEFD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759103091; cv=none; b=YmsoRowW3TJj9uRAeqjjwTyT679v6xTv4iECjAiYxKXrivSuASBK3wd4zKTahAb8GZeN5rupJyB6NpvjIKTdYcXBYwILZISv3kK2g6kNwFxemfoc/vtu51Hjj2RlsTAVfc5r5f+yX0JMVq25D6gEoERsTnMMba5xZNvfuM12FbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759103091; c=relaxed/simple;
	bh=sJsUEYDm04IlD5BcEzyeHcZnTd3/h7nvQDAwSSwBfB8=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=djN3jwimFZ7zqt68vuiNjngXhOV9T46Pw0HjujrtSocofD+8+134qD38AnZTxqqnq2mQIUoy8jsiTzsMPz95MQbap9q+VRvTuJDPWH1SNhvLQtl/fpvSI/hpyPlVB850km9WJhO2Cy0M01/7iOg3Cbtgr5SjWYho5oIEJccHL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNfdX1Ri; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3352018e051so4071781a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759103088; x=1759707888; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6uZqv7BF8fxgj0fdChKvhdHEIE5MC9E1zQaVfiqjeLk=;
        b=jNfdX1RibgiF7W0bCd6LywAGnh4tvT1ifG14iBGKl5Twp80DSI/4QDXwxg3T8jPH+T
         Qp+yGpKSiY4V/sR5flcmTR7X3aIkQ7cdyXUAesJAvjKoMmF+r03rCNKmpJXz9cDc5Ost
         SOrQJy3lGNn63lmY5AEG5ZRpGJfZ9XGAXSNUQN0bQ3X7nfMo6J6JwBojQjw9D1VGd42+
         XkqYUnFgJh0pdu/CborDnY4y8fduk6vvEbhtmPHOgrlnXaYgwwiPIqO/1Oc4YyZgty+B
         6ErpwS7PCSZ52gz+4IjwEdHFLaBEuvujOANMR5I6lallNInkzEq/qCyqTcnUS3LIeLjF
         F2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759103088; x=1759707888;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uZqv7BF8fxgj0fdChKvhdHEIE5MC9E1zQaVfiqjeLk=;
        b=Z4BXIgK3Q2C5P5WCqbckBV3ZByu47EOje9eGnHqXwMpGUTs1mdKOGv+FnI5EOVFg2h
         8nHn+VjVDNE45IGDZSDLeL1iRFxXNu//dw1DjB0Qpaaiu5zB/99r5pTNEPjklPYon6sy
         7vCkFuCV4blxr0ThfFvE3ntcFh7uAq81UV5Q5UDh6C5C4Xui8jgM1CNy1/R9JPEdLA6l
         e3z6LzCFZX1IAGwwGuYmLgY+2oEqy9uF0xnsoMitJEOdugAJ/CoJSax9jvQvdi0SNd8V
         +v0kleUrqwSr7Zh9wB5AOprMfzRQB7jgSxJGZq1DmY7y7B5O26XeSz4j5Y0KHD2826J0
         +KjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpe7GSB9CEmAKy52pXLHB9fgSFe30ssPz1NhqbcBbGTeDTcboIXQWVEzx5L1rTcX8MaxFKktmQ5PMrbyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn/KVDlSUauNzo4rmzYJ6OP8gp++CIuinAWQ7oxpbgSK5ScT/u
	Y0Izpq+j2A12SZVZNzOfs21YDvI3Q+N5YkCtxoRfGfxm0Ly6/40QRJwh
X-Gm-Gg: ASbGncvt7hpWS6dhvWZ52+SNQ2GZC4SyuimkUqwCwIno7V6vtCVmBuIsA8ZZpcLBwt5
	QBFy9AchkY5ZnEwrFnfP7CzY6ajWgpdSGJve9x10vJKwX9YoK+fe4n+Ka1aLp4msRYKD9rlGH2/
	yGiuHdislKaLJSkjC49fSfKYTU9TIj752Hsv4EtjKyNg4gX7uCbuRRfAbtjE8QHOLeu6D+MUvT7
	TOwGJrDNz/NEJme8+zsTQBQS3LfzURZeywH19CcL9XKCmLmw9smp6Vt/O3/28kmrWP4EF8CuHZb
	aVyWoPBO5C7MxsccIRBb9orkNTEh0wJ8ZklsC5TwPZkcTKUB3Xh0XY31n0bZ7UsjchLulsIfrdq
	XYYA+lxtB51vmQqh0XmuLRbk=
X-Google-Smtp-Source: AGHT+IFj//9uz6PZ64Fp8xLgbmwavKPz7itU0iNGPQP1qHGouTJGs8TCRcD5CUA+pCELoLRzDCisFA==
X-Received: by 2002:a17:90b:4b8b:b0:32e:9a24:2df9 with SMTP id 98e67ed59e1d1-3342a26c34fmr16883085a91.14.1759103088488;
        Sun, 28 Sep 2025 16:44:48 -0700 (PDT)
Received: from 1337 ([136.159.213.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33474b1f455sm11587891a91.24.2025.09.28.16.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 16:44:47 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore
 <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, Daniel Verkamp
 <dverkamp@chromium.org>, Jeff Xu <jeffxu@chromium.org>, =?utf-8?Q?Thi?=
 =?utf-8?Q?=C3=A9baud_Weksteen?= <tweek@google.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH RFC 0/4] landlock: add LANDLOCK_SCOPE_MEMFD_EXEC execution
Date: Sun, 28 Sep 2025 17:37:02 -0600
References: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
 <20250918.io7too8ain7A@digikod.net>
User-agent: mu4e 1.10.8; emacs 30.2
In-reply-to: <20250918.io7too8ain7A@digikod.net>
Message-ID: <878qhy2lch.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the detailed reply Micka=C3=ABl!

Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> writes:

> Thanks for this patch series Abhinav!  The code looks good overall, but
> we should clarify the design.  Sorry for the delayed response, it is on
> my radar now.
>
> CCing Jeff and Daniel
>
> On Sat, Jul 19, 2025 at 05:13:10AM -0600, Abhinav Saxena wrote:
>> This patch series introduces LANDLOCK_SCOPE_MEMFD_EXEC, a new Landlock
>> scoping mechanism that restricts execution of anonymous memory file
>> descriptors (memfd) created via memfd_create(2). This addresses security
>> gaps where processes can bypass W^X policies and execute arbitrary code
>> through anonymous memory objects.
>>=20
>> Fixes: <https://github.com/landlock-lsm/linux/issues/37>
>>=20
>> SECURITY PROBLEM
>> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
>>=20
>> Current Landlock filesystem restrictions do not cover memfd objects,
>> allowing processes to:
>>=20
>> 1. Read-to-execute bypass: Create writable memfd, inject code,
>>    then execute via mmap(PROT_EXEC) or direct execve()
>> 2. Anonymous execution: Execute code without touching the filesystem via
>>    execve(=E2=80=9C/proc/self/fd/N=E2=80=9D) where N is a memfd descript=
or
>
>> 3. Cross-domain access violations: Pass memfd between processes to
>>    bypass domain restrictions
>
> Landlock only restricts access at open time, which is a useful property.
> This enables to create more restricted sandboxes but still get access to
> outside resources via trusted processes.  If the process passing the FDs
> is not trusted, the sandboxed process could just ask to execute
> arbitrary code outside the sandbox anyway.
>
> However, the Landlock scopes are designed to block IPC from within a
> sandbox to outside the sandbox.  We could have a new scope to forbid a
> sandbox process to receive or inherit file descriptors, but that would
> be a different and generic feature.  For compatibility reasons, this
> might not be easy to implement and I think there are more important
> features to implement before that.
>
> Thinking more about it, restricting memfd should not be a =E2=80=9Cscoped=
=E2=80=9D flag
> because the semantic is not the same, but we should have a new ruleset
> property instead, something like =E2=80=9Cruleset.denied=E2=80=9D with a =
related
> LANDLOCK_DENY_EXECUTE_MEMFD flag.  This flag will only have an impact on
> newly created memfd from a sandboxed process with this restriction at
> creation time. This could be implemented with hook_file_alloc_security()
> by checking if the file is indeed a memfd and checking inode->i_mode for
> executability bits (which would imply MFD_NOEXEC_SEAL).
>

Thanks for the clarification! So if I understood correctly we are
proposing adding a `denied` field to the `landlock_ruleset_attr` struct

struct landlock_ruleset_attr {
    __u64 handled_access_fs;
    __u64 handled_access_net;
    __u64 scoped;
    __u64 denied;              /* New field */
};

which allows memfd_create() to be allowed by default unless
LANDLOCK_DENY_EXECUTE_MEMFD bit is set. Also it seems Thi=C3=A9baud
Weksteen=E2=80=99s patch[1] will land, and maybe we can use
security_inode_init_security_anon instead? What do you think?

Apologies for my ignorance, do we have to wait till his patch has
landed into Linus=E2=80=99s tree?

>>=20
>> These scenarios can occur in sandboxed environments where filesystem
>> access is restricted but memfd creation remains possible.
>>=20
>> IMPLEMENTATION
>> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
>>=20
>> The implementation adds hierarchical execution control through domain
>> scoping:
>>=20
>> Core Components:
>> - is_memfd_file(): Reliable memfd detection via =E2=80=9Cmemfd:=E2=80=9D=
 dentry prefix
>> - domain_is_scoped(): Cross-domain hierarchy checking (moved to domain.c)
>> - LSM hooks: mmap_file, file_mprotect, bprm_creds_for_exec
>> - Creation-time restrictions: hook_file_alloc_security
>>=20
>> Security Matrix:
>> Execution decisions follow domain hierarchy rules preventing both
>> same-domain bypass attempts and cross-domain access violations while
>> preserving legitimate hierarchical access patterns.
>>=20
>> Domain Hierarchy with LANDLOCK_SCOPE_MEMFD_EXEC:
>> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
>>=20
>> Root (no domain) - No restrictions
>>   |
>>   +=E2=80=93 Domain A [SCOPE_MEMFD_EXEC] Layer 1
>>   |     +=E2=80=93 memfd_A (tagged with Domain A as creator)
>>   |     |
>>   |     +=E2=80=93 Domain A1 (child) [NO SCOPE] Layer 2
>>   |     |     +=E2=80=93 Inherits Layer 1 restrictions from parent
>>   |     |     +=E2=80=93 memfd_A1 (can create, inherits restrictions)
>>   |     |     +=E2=80=93 Domain A1a [SCOPE_MEMFD_EXEC] Layer 3
>>   |     |           +=E2=80=93 memfd_A1a (tagged with Domain A1a)
>>   |     |
>>   |     +=E2=80=93 Domain A2 (child) [SCOPE_MEMFD_EXEC] Layer 2
>>   |           +=E2=80=93 memfd_A2 (tagged with Domain A2 as creator)
>>   |           +=E2=80=93 CANNOT access memfd_A1 (different subtree)
>>   |
>>   +=E2=80=93 Domain B [SCOPE_MEMFD_EXEC] Layer 1
>>         +=E2=80=93 memfd_B (tagged with Domain B as creator)
>>         +=E2=80=93 CANNOT access ANY memfd from Domain A subtree
>>=20
>> Execution Decision Matrix:
>> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
>> Executor->  |  A  | A1 | A1a | A2 | B  | Root
>> Creator     |     |    |     |    |    |
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94|=E2=80=94=E2=80=93|=E2=80=94-|=E2=
=80=94=E2=80=93|=E2=80=94-|=E2=80=94-|=E2=80=94=E2=80=93
>> Domain A    |  X  | X  | X   | X  | X  |  Y
>> Domain A1   |  Y  | X  | X   | X  | X  |  Y
>> Domain A1a  |  Y  | Y  | X   | X  | X  |  Y
>> Domain A2   |  Y  | X  | X   | X  | X  |  Y
>> Domain B    |  X  | X  | X   | X  | X  |  Y
>> Root        |  Y  | Y  | Y   | Y  | Y  |  Y
>>=20
>> Legend: Y =3D Execution allowed, X =3D Execution denied
>
> Because checks should not be related to scopes, this will be much
> simpler.
>
>>=20
>> Scenarios Covered:
>> - Direct mmap(PROT_EXEC) on memfd files
>> - Two-stage mmap(PROT_READ) + mprotect(PROT_EXEC) bypass attempts
>> - execve("/proc/self/fd/N") anonymous execution
>> - execveat() and fexecve() file descriptor execution
>> - Cross-process memfd inheritance and IPC passing
>>=20
>> TESTING
>> `=3D=3D=3D=3D=3D'
>>=20
>> All patches have been validated with:
>> - scripts/checkpatch.pl =E2=80=93strict (clean)
>> - Selftests covering same-domain restrictions, cross-domain=20
>>   hierarchy enforcement, and regular file isolation
>> - KUnit tests for memfd detection edge cases
>
> Thanks for all these tests!
>
>>=20
>> DISCLAIMER
>> `=3D=3D=3D=3D=3D=3D=3D=3D'
>>=20
>> My understanding of Landlock scoping semantics may be limited, but this
>> implementation reflects my current understanding based on available
>> documentation and code analysis. I welcome feedback and corrections
>> regarding the scoping logic and domain hierarchy enforcement.
>>=20
>> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
>> =E2=80=94
>> Abhinav Saxena (4):
>>       landlock: add LANDLOCK_SCOPE_MEMFD_EXEC scope
>>       landlock: implement memfd detection
>>       landlock: add memfd exec LSM hooks and scoping
>>       selftests/landlock: add memfd execution tests
>>=20
>>  include/uapi/linux/landlock.h                      |   5 +
>>  security/landlock/.kunitconfig                     |   1 +
>>  security/landlock/audit.c                          |   4 +
>>  security/landlock/audit.h                          |   1 +
>>  security/landlock/cred.c                           |  14 -
>>  security/landlock/domain.c                         |  67 ++++
>>  security/landlock/domain.h                         |   4 +
>>  security/landlock/fs.c                             | 405 ++++++++++++++=
++++++-
>>  security/landlock/limits.h                         |   2 +-
>>  security/landlock/task.c                           |  67 =E2=80=94-
>>  =E2=80=A6/selftests/landlock/scoped_memfd_exec_test.c    | 325 ++++++++=
+++++++++
>>  11 files changed, 812 insertions(+), 83 deletions(-)
>> =E2=80=94
>> base-commit: 5b74b2eff1eeefe43584e5b7b348c8cd3b723d38
>> change-id: 20250716-memfd-exec-ac0d582018c3
>>=20
>> Best regards,
>> =E2=80=93=20
>> Abhinav Saxena <xandfury@gmail.com>
>>=20
>>=20

Best,
Abhinav

[1] - <https://lore.kernel.org/all/20250918020434.1612137-1-tweek@google.co=
m/>

--=-=-=--

