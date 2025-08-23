Return-Path: <linux-kernel+bounces-783116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BA7B3298B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA99F1B66181
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBFC2E719D;
	Sat, 23 Aug 2025 15:28:08 +0000 (UTC)
Received: from cloud48395.mywhc.ca (cloud48395.mywhc.ca [173.209.37.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC707239E92
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.209.37.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755962888; cv=none; b=dA65WhXPIsLoTUiQDVWz7vPc95H08vQxlTmBkmrqf9XPw+f0s5ymZIogx6PqQBnPV6j+Bh9PGM/9oD1HeVnrcPgOF/xm3ehMRBy+CuKUNM/Dr4OahPnj7M9ECpkIBhmyQVPY2pAZJuFb3e/lIEJcdSlCNlaxSUWjgaySbKhRpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755962888; c=relaxed/simple;
	bh=NFX5CFV0f0Gx0I8D+HyciVNvwQuMJmocS6ycHlIREjY=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=T16xLs82YPn6faHAEg0gSuf68R98wgsazPHHkYrk/lGCwCLNpi4ozbddZYc4xwKrok6qPe4OkmwbN0aXU7jWqAYzoI2WVJ2jABP547d0qAhju78xq3MBHcGJKxzXBCicQdBScFz3XklZRw9PEyvF+1L7BZw4mPAzliqaUVbVxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com; spf=pass smtp.mailfrom=trillion01.com; arc=none smtp.client-ip=173.209.37.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trillion01.com
Received: from [45.44.224.220] (port=60594 helo=[192.168.1.177])
	by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <olivier@trillion01.com>)
	id 1uppnr-000000007T8-1Ei8
	for linux-kernel@vger.kernel.org;
	Sat, 23 Aug 2025 11:05:11 -0400
Message-ID: <bd0914ce41785654abb7821f764c820815aea362.camel@trillion01.com>
Subject: [QUESTION] Core dumps inhibited for ASan binary with setcap
 capabilities despite fs.suid_dumpable=2
From: Olivier Langlois <olivier@trillion01.com>
To: linux-kernel@vger.kernel.org
Date: Sat, 23 Aug 2025 11:05:09 -0400
Autocrypt: addr=olivier@trillion01.com; prefer-encrypt=mutual;
 keydata=mQINBFYd0ycBEAC53xedP1NExPwtBnDkVuMZgRiLmWoQQ8U7vEwt6HVGSsMRHx9smD76i
 5rO/iCT6tDIpZoyJsTOh1h2NTn6ZkoFSn9lNOJksE77/n7HNaNxiBfvZHsuNuI53CkYFix9JhzP3t
 g5nV/401re30kRfA8OPivpnj6mZhU/9RTwjbVPPb8dPlm2gFLXwGPeDITgSRs+KJ0mM37fW8EatJs
 0a8J1Nk8wBvT7ce+S2lOrxDItra9pW3ukze7LMirwvdMRC5bdlw2Lz03b5NrOUq+Wxv7szn5Xr9f/
 HdaCH7baWNAO6H/O5LbJ3zndewokEmKk+oCIcXjaH0U6QK5gJoO+3Yt5dcTo92Vm3VMxzK2NPFXgp
 La7lR9Ei0hzQ0zptyFFyftt9uV71kMHldaQaSfUTsu9dJbnS2kI/j+F2S1q6dgKi3DEm0ZRGvjsSG
 rkgPJ5T16GI1cS2iQntawdr0A1vfXiB9xZ1SMGxL/l6js9BVlIx/CBGOJ4L190QmxJlcAZ2VnQzrl
 ramRUv01xb00IPJ5TBft5IJ+SY0FnY9pIERIl6w9khwLt/oGuKNmUHmzJGYoJHYfh72Mm8RQ1R/JS
 o6v85ULBGdEC3pQq1j//OPyH3egiXIwFq6BtULH5CvsxQkSqgj1MpjwfgVJ8VbjNwqwBXHjooEORj
 vFQqWQki6By3QARAQABtDJPbGl2aWVyIExhbmdsb2lzIChNeSBrZXkpIDxvbGl2aWVyQHRyaWxsaW
 9uMDEuY29tPokCNwQTAQgAIQUCVh3TJwIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBlaka
 GGsWHEI1AD/9sbj+vnFU29WemVqB4iW+9RrHIcbXI4Jg8WaffTQ8KvVeCJ4otzgVT2nHC2A82t4PF
 0tp21Ez17CKDNilMvOt8zq6ZHx36CPjoqUVjAdozOiBDpC4qB6ZKYn+gqSENO4hqmmaOW57wT9vII
 v6mtHmnFvgpOEJl6wbs8ArHDt0BLSjc8QQfvBhoKoWs+ijQTyvFGlQl0oWxEbUkR1J3gdft9Oj9xQ
 G4OFo73WaSEK/L9IalU2ulCBC+ucSP9McoDxy1i1u8HUDrV5wBY1zafc9zVBcMNH6+ZjxwQmZXqtz
 ATzB3RbSFHAdmvxl8q6MeS2yx7Atk0CXgW9z5k2KeuZhz5rVV5A+D19SSGzW11uYXsibZx/Wjr9xB
 KHB6U7qh5sRHaQS191NPonKcsXXAziR+vxwQTP7ZKfy+g5N/e6uivoUnQrl9uvUDDPXEpwVNSoVws
 Vn4tNyrGEdN11pHDbH5fSGzdpbY8+yczUoxMmsEQe/fpVwRBZUqafRn2TVUhV0qqzsUuQcTNw1zIZ
 JgvkqrHgd4ivd2b1bXBczmu/wMGpEnF6cWzSQDiwC1NF3i+gHCuD8IX1ujThWtzXsn0VtrMkrRCbn
 ponVQ6HcbRYYXPuK0HRRjCSuAKo5porVONepiOSmu0FBrpGqBkpBtLrzKXoi1yt/7a/wGdMcVhYGg
 vA==
Organization: Trillion01 Inc
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello LKML,

I'm encountering an issue where core dumps are not generated for an ASan-co=
mpiled binary with setcap capabilities (e.g.,
cap_net_admin,cap_net_raw,cap_sys_nice=3Dep), even with fs.suid_dumpable se=
t to 2 and
ASAN_OPTIONS=3Ddisable_coredump=3D0:unmap_shadow_on_exit=3D1:abort_on_error=
=3D1.

Actually playing with fs.suid_dumpable settings has no incidence on the out=
come. Whether it is 0 or 2.
I have tested playing with this setting as suggested by Grok...
(This email has mostly been generated by Grok. It cannot act as an agent ye=
t...)

System details:
- Kernel: Linux aws-dublin 6.11.3-1-ec2 #1 SMP Sun, 13 Oct 2024 15:39:09 +0=
000 x86_64 GNU/Linux
- GCC: 15.1.1

Reproduction:

lano1106@aws-dublin ~/dev/kraken $ cat test_asan.cpp=20
#include <cstdlib>

int main() {
    *(int*)0 =3D 0;  // Force SEGV like your crash
    return 0;
}

lano1106@aws-dublin ~/dev/kraken $ g++ -fsanitize=3Daddress -g test_asan.cp=
p -o test_asan
lano1106@aws-dublin ~/dev/kraken $ ASAN_OPTIONS=3Ddisable_coredump=3D0:unma=
p_shadow_on_exit=3D1:abort_on_error=3D1 ./test_asan
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D3310744=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00000=
0000000 (pc 0x56015f60f199 bp 0x7ffdd9466b50 sp 0x7ffdd9466b50 T0)
=3D=3D3310744=3D=3DThe signal is caused by a WRITE memory access.
=3D=3D3310744=3D=3DHint: address points to the zero page.
    #0 0x56015f60f199 in main /home/lano1106/dev/kraken/test_asan.cpp:4
    #1 0x7f2fc3a376b4  (/usr/lib/libc.so.6+0x276b4) (BuildId: 468e3585c7944=
91a48ea75fceb9e4d6b1464fc35)
    #2 0x7f2fc3a37768 in __libc_start_main (/usr/lib/libc.so.6+0x27768) (Bu=
ildId: 468e3585c794491a48ea75fceb9e4d6b1464fc35)
    #3 0x56015f60f084 in _start (/home/lano1106/dev/kraken/test_asan+0x1084=
) (BuildId: 35f24e6e649e793dac986336cd20c25b0cc70e85)

=3D=3D3310744=3D=3DRegister values:
rax =3D 0x0000000000000000  rbx =3D 0x0000000000000000  rcx =3D 0x000000000=
0000000  rdx =3D 0x0000000000000000 =20
rdi =3D 0x0000000000000000  rsi =3D 0x0000000000000003  rbp =3D 0x00007ffdd=
9466b50  rsp =3D 0x00007ffdd9466b50 =20
 r8 =3D 0x00007f2fc3bf6680   r9 =3D 0x00007f2fc3bf8000  r10 =3D 0x000000000=
0000000  r11 =3D 0x00007f2fc4130530 =20
r12 =3D 0x00007ffdd9466c78  r13 =3D 0x0000000000000001  r14 =3D 0x00007f2fc=
489f000  r15 =3D 0x000056015f611d78 =20
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV /home/lano1106/dev/kraken/test_asan.cpp:4 i=
n main
=3D=3D3310744=3D=3DABORTING
Aborted (core dumped)
lano1106@aws-dublin ~/dev/kraken :( $ sudo setcap cap_net_raw,cap_net_admin=
,cap_sys_nice=3D+ep test_asan
[sudo] password for lano1106:=20
lano1106@aws-dublin ~/dev/kraken $ ASAN_OPTIONS=3Ddisable_coredump=3D0:unma=
p_shadow_on_exit=3D1:abort_on_error=3D1 ./test_asan
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D3310762=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00000=
0000000 (pc 0x556b9b127199 bp 0x7ffc9d3d1490 sp 0x7ffc9d3d1490 T0)
=3D=3D3310762=3D=3DThe signal is caused by a WRITE memory access.
=3D=3D3310762=3D=3DHint: address points to the zero page.
    #0 0x556b9b127199 in main /home/lano1106/dev/kraken/test_asan.cpp:4
    #1 0x7fa98f8376b4  (/usr/lib/libc.so.6+0x276b4) (BuildId: 468e3585c7944=
91a48ea75fceb9e4d6b1464fc35)
    #2 0x7fa98f837768 in __libc_start_main (/usr/lib/libc.so.6+0x27768) (Bu=
ildId: 468e3585c794491a48ea75fceb9e4d6b1464fc35)
    #3 0x556b9b127084 in _start (/home/lano1106/dev/kraken/test_asan+0x1084=
) (BuildId: 35f24e6e649e793dac986336cd20c25b0cc70e85)

=3D=3D3310762=3D=3DRegister values:
rax =3D 0x0000000000000000  rbx =3D 0x0000000000000000  rcx =3D 0x000000000=
0000000  rdx =3D 0x0000000000000000 =20
rdi =3D 0x0000000000000000  rsi =3D 0x0000000000000003  rbp =3D 0x00007ffc9=
d3d1490  rsp =3D 0x00007ffc9d3d1490 =20
 r8 =3D 0x00007fa98f9f6680   r9 =3D 0x00007fa98f9f8000  r10 =3D 0x000000000=
0000000  r11 =3D 0x00007fa98ff30530 =20
r12 =3D 0x00007ffc9d3d15b8  r13 =3D 0x0000000000000001  r14 =3D 0x00007fa99=
05db000  r15 =3D 0x0000556b9b129d78 =20
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV /home/lano1106/dev/kraken/test_asan.cpp:4 i=
n main
=3D=3D3310762=3D=3DABORTING
lano1106@aws-dublin ~/dev/kraken :( $ uname -a
Linux aws-dublin 6.11.3-1-ec2 #1 SMP Sun, 13 Oct 2024 15:39:09 +0000 x86_64=
 GNU/Linux

