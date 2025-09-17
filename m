Return-Path: <linux-kernel+bounces-820441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E97B7E025
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FF71BC76F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71AD34F49B;
	Wed, 17 Sep 2025 10:13:04 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA68306B32;
	Wed, 17 Sep 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103974; cv=none; b=knws8hUSZAYuTWJw9wUXW+QtRTsO9JMOjyF0+ofqAt3SnqvCnyW9qd0jt937gpBTgUt5SoqXw5hCDLhBjKcModXVFz8qDfoCJKykwRkRzFH41F7Gh9gbBYQwwp18TOVsNMKQ5SHgXw7sZR+zoxmLb9msO4eX82lI8feyG975JmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103974; c=relaxed/simple;
	bh=lNz8kz6tTnTDo8AfdnavWFthtRKlS8tLKzjj9cR7ggQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Yye3vpnlyfqGvmAEFfEKXdO6e5IlgUalpvUP8TtgD+pIqDX2th86kiy9lF417oYAo16YEVxGoA38X2x1HTwIduX2oXlObYsm62tubWiNL8UhAdzX785rsq0LDdJZzhj8Y2rVie2oevMAHzYrZ5JaW75BIbWHAg+qJRM8gojy0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d3bbb68a93ae11f0b29709d653e92f7d-20250917
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c52836f0-c34d-48eb-bd89-86a185266a16,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:12b3d70a4e86f2f7b35cba59c5e58131,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:1,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,OSH|NGT
X-CID-BAS: 2,OSH|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d3bbb68a93ae11f0b29709d653e92f7d-20250917
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1012001188; Wed, 17 Sep 2025 18:12:33 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 2F818160042A2;
	Wed, 17 Sep 2025 18:12:33 +0800 (CST)
X-ns-mid: postfix-68CA8990-6440601581
Received: from [172.25.120.57] (unknown [172.25.120.57])
	by node4.com.cn (NSMail) with ESMTPA id 0804B160042A0;
	Wed, 17 Sep 2025 10:12:31 +0000 (UTC)
Message-ID: <0540df54-efd6-4b79-90f9-ec305e1f5f7e@kylinos.cn>
Date: Wed, 17 Sep 2025 18:12:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] thunderbolt: Re-add DP resources on resume
To: Jiayi Li <lijiayi@kylinos.cn>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20250917082456.1790252-1-lijiayi@kylinos.cn>
From: =?UTF-8?B?5p2O5L2z5oCh?= <lijiayi@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20250917082456.1790252-1-lijiayi@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


As requested, I've attached the complete dmesg output (from boot to=20
after resume) reproducing the issue.

Testing Methodology:
1. Start with the Targus Thunderbolt dock already connected to the system
2. Enter S3 suspend (sleep) with no DP monitor connected to the dock
3. Resume from S3
4. After the system has fully resumed, connect the DP monitor to the dock

=E5=9C=A8 2025/9/17 16:24, Jiayi Li =E5=86=99=E9=81=93:
> During suspend, DP resources are released through tb_disconnect_and_rel=
ease_dp()
> but were not being re-added during resume, preventing DP tunnels from b=
eing
> re-established.
>=20
> This caused DP displays connected via Thunderbolt docks (such as Targus=
 docks)
> to not display after S3 resume. The issue was visible in logs:
>=20
> [246.397437] tb_cfg_ack_plug:819: thunderbolt 0000:2c:00.0: acking hot =
plug event on 3:10
> [246.398282] tb_dp_resource_available:2019: thunderbolt 0000:2c:00.0: 3=
:10: DP OUT resource available
> [246.398291] tb_tunnel_dp:1875: thunderbolt 0000:2c:00.0: looking for D=
P IN <-> DP OUT pairs:
> [246.398294] tb_tunnel_dp:1899: thunderbolt 0000:2c:00.0: no suitable D=
P IN adapter available, not tunneling
>=20
> Add call to tb_add_dp_resources() in tb_resume_noirq() to ensure DP res=
ources
> are properly re-added during resume, allowing DP tunnels to be re-estab=
lished.
>=20
> Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
> ---
>   drivers/thunderbolt/tb.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index c14ab1fbeeaf..cb652df3fc9f 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -3119,6 +3119,7 @@ static int tb_resume_noirq(struct tb *tb)
>   		tb_switch_reset(tb->root_switch);
>  =20
>   	tb_switch_resume(tb->root_switch, false);
> +	tb_add_dp_resources(tb->root_switch);
>   	tb_free_invalid_tunnels(tb);
>   	tb_free_unplugged_children(tb->root_switch);
>   	tb_restore_children(tb->root_switch);

dmesg:
[    0.000000] Linux version 5.4.18-151+ (lijiayi@kylin-pc) (gcc version=20
12.4.0 (Debian 12.4.0-5)) #231 SMP Wed Sep 10 15:04:40 CST 2025 ()
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.4.18-151+=20
root=3DUUID=3D8c10b5c5-7cef-466c-acaf-a662a005fbad ro quiet splash=20
loglevel=3D0 thunderbolt.dyndbg=3D+plft=20
resume=3DUUID=3D0f053111-bb39-491e-a173-f534050f8dfd security=3D
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating=20
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832=20
bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000003ffffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x0000000004000000-0x000000000403ffff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x0000000004040000-0x0000000005dfffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x0000000005e00000-0x0000000005ffffff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x0000000006000000-0x00000000730f5fff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x00000000730f6000-0x0000000076edcfff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x0000000076edd000-0x0000000076f1cfff]=20
ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000076f1d000-0x00000000797fdfff]=20
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000797fe000-0x000000007a9fdfff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x000000007a9fe000-0x000000007bffffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000007c000000-0x000000007fffffff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000dfa00000-0x00000000dfa00fff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000dfa80000-0x00000000dfafffff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000feafffff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc0000-0x00000000fedc0fff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedc5fff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc7000-0x00000000fedc7fff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc9000-0x00000000fedcafff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000277efffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x0000000277f00000-0x000000027fffffff]=20
reserved
[    0.000000] BIOS-e820: [mem 0x0000fffd00000000-0x0000ffffffffffff]=20
reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x4e9a2018-0x4e9cd057] usable =3D=3D> us=
able
[    0.000000] e820: update [mem 0x4e9a2018-0x4e9cd057] usable =3D=3D> us=
able
[    0.000000] e820: update [mem 0x4e97c018-0x4e9a1257] usable =3D=3D> us=
able
[    0.000000] e820: update [mem 0x4e97c018-0x4e9a1257] usable =3D=3D> us=
able
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem=20
0x0000000000000000-0x000000000009efff] usable
[    0.000000] reserve setup_data: [mem=20
0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem=20
0x0000000000100000-0x0000000003ffffff] usable
[    0.000000] reserve setup_data: [mem=20
0x0000000004000000-0x000000000403ffff] reserved
[    0.000000] reserve setup_data: [mem=20
0x0000000004040000-0x0000000005dfffff] usable
[    0.000000] reserve setup_data: [mem=20
0x0000000005e00000-0x0000000005ffffff] reserved
[    0.000000] reserve setup_data: [mem=20
0x0000000006000000-0x000000004e97c017] usable
[    0.000000] reserve setup_data: [mem=20
0x000000004e97c018-0x000000004e9a1257] usable
[    0.000000] reserve setup_data: [mem=20
0x000000004e9a1258-0x000000004e9a2017] usable
[    0.000000] reserve setup_data: [mem=20
0x000000004e9a2018-0x000000004e9cd057] usable
[    0.000000] reserve setup_data: [mem=20
0x000000004e9cd058-0x00000000730f5fff] usable
[    0.000000] reserve setup_data: [mem=20
0x00000000730f6000-0x0000000076edcfff] reserved
[    0.000000] reserve setup_data: [mem=20
0x0000000076edd000-0x0000000076f1cfff] ACPI data
[    0.000000] reserve setup_data: [mem=20
0x0000000076f1d000-0x00000000797fdfff] ACPI NVS
[    0.000000] reserve setup_data: [mem=20
0x00000000797fe000-0x000000007a9fdfff] reserved
[    0.000000] reserve setup_data: [mem=20
0x000000007a9fe000-0x000000007bffffff] usable
[    0.000000] reserve setup_data: [mem=20
0x000000007c000000-0x000000007fffffff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000dfa00000-0x00000000dfa00fff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000dfa80000-0x00000000dfafffff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000fea00000-0x00000000feafffff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000fedc0000-0x00000000fedc0fff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000fedc2000-0x00000000fedc5fff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000fedc7000-0x00000000fedc7fff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000fedc9000-0x00000000fedcafff] reserved
[    0.000000] reserve setup_data: [mem=20
0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem=20
0x0000000100000000-0x0000000277efffff] usable
[    0.000000] reserve setup_data: [mem=20
0x0000000277f00000-0x000000027fffffff] reserved
[    0.000000] reserve setup_data: [mem=20
0x0000fffd00000000-0x0000ffffffffffff] reserved
[    0.000000] efi: EFI v2.80 by Xorcore
[    0.000000] efi:  SMBIOS=3D0x7a675000  SMBIOS 3.0=3D0x7a673000=20
ACPI=3D0x76f1c000  ACPI 2.0=3D0x76f1c014  MEMATTR=3D0x6bf72018
[    0.000000] efi: memattr: Unexpected EFI Memory Attributes table=20
version 2
[    0.000000] secureboot: Secure boot disabled
[    0.000000] SMBIOS 3.4.1 present.
[    0.000000] DMI: Suma=20
N50/22DD2    , BIOS CSCH051019 08/15/2025
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2795.847 MHz processor
[    0.000324] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> re=
served
[    0.000326] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000334] last_pfn =3D 0x277f00 max_arch_pfn =3D 0x400000000
[    0.000339] MTRR default type: uncachable
[    0.000340] MTRR fixed ranges enabled:
[    0.000341]   00000-9FFFF write-back
[    0.000342]   A0000-BFFFF write-through
[    0.000343]   C0000-FFFFF uncachable
[    0.000343] MTRR variable ranges enabled:
[    0.000345]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000346]   1 base 00007C000000 mask FFFFFC000000 uncachable
[    0.000347]   2 disabled
[    0.000347]   3 disabled
[    0.000347]   4 disabled
[    0.000348]   5 disabled
[    0.000348]   6 disabled
[    0.000349]   7 base 0000FF000000 mask FFFFFF000000 write-protect
[    0.000351] TOM2: 0000000280000000 aka 10240M
[    0.000881] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC-=20
WT
[    0.000981] last_pfn =3D 0x7c000 max_arch_pfn =3D 0x400000000
[    0.006710] check: Scanning 1 areas for low memory corruption
[    0.006715] Using GB pages for direct mapping
[    0.006717] BRK [0x220001000, 0x220001fff] PGTABLE
[    0.006719] BRK [0x220002000, 0x220002fff] PGTABLE
[    0.006720] BRK [0x220003000, 0x220003fff] PGTABLE
[    0.006782] BRK [0x220004000, 0x220004fff] PGTABLE
[    0.006784] BRK [0x220005000, 0x220005fff] PGTABLE
[    0.007055] BRK [0x220006000, 0x220006fff] PGTABLE
[    0.007174] BRK [0x220007000, 0x220007fff] PGTABLE
[    0.007234] BRK [0x220008000, 0x220008fff] PGTABLE
[    0.007318] BRK [0x220009000, 0x220009fff] PGTABLE
[    0.007446] BRK [0x22000a000, 0x22000afff] PGTABLE
[    0.007526] secureboot: Secure boot disabled
[    0.007527] RAMDISK: [mem 0x3843a000-0x3ca6cfff]
[    0.007533] ACPI: Early table checksum verification disabled
[    0.007537] ACPI: RSDP 0x0000000076F1C014 000024 (v02 HYGON )
[    0.007540] ACPI: XSDT 0x0000000076F1B0E8 00009C (v01 HYGON  Hygon=20
00000002      01000013)
[    0.007546] ACPI: FACP 0x0000000076F16000 000114 (v06 HYGON  Hygon=20
00000002      01000013)
[    0.007551] ACPI: DSDT 0x0000000076F10000 0054A1 (v02 HYGON  Hygon=20
03242016 INTL 20190703)
[    0.007554] ACPI: FACS 0x000000007774F000 000040
[    0.007556] ACPI: SSDT 0x0000000076F1A000 0000D2 (v02 HYGON  HGN ALIB=20
00000002 MSFT 04000000)
[    0.007559] ACPI: SSDT 0x0000000076F19000 00020C (v02 HYGON  Hygon=20
00000002      01000013)
[    0.007561] ACPI: MCFG 0x0000000076F18000 00003C (v01 HYGON  Hygon=20
00000002      01000013)
[    0.007564] ACPI: HPET 0x0000000076F17000 000038 (v01 HYGON  Hygon=20
00000002      01000013)
[    0.007566] ACPI: SSDT 0x0000000076F0E000 001BF4 (v02 HYGON  HGN CPU=20
00000001 HYGN 00000001)
[    0.007569] ACPI: CRAT 0x0000000076F0D000 000F50 (v01 HYGON  HGN CRAT=20
00000001 HYGN 00000001)
[    0.007571] ACPI: CDIT 0x0000000076F0C000 000029 (v01 HYGON  HGN CDIT=20
00000001 HYGN 00000001)
[    0.007574] ACPI: UEFI 0x000000007774C000 000042 (v01=20
00000000      00000000)
[    0.007576] ACPI: IVRS 0x0000000076F0B000 0000C8 (v02 HYGON  HGN IVRS=20
00000001 HYGN 00000000)
[    0.007579] ACPI: FPDT 0x0000000076F0A000 000044 (v01 HYGON  Hygon=20
00000002      01000013)
[    0.007581] ACPI: SSDT 0x0000000076F06000 0030BE (v02 Hygon  CPMCMN=20
00000001 INTL 20190703)
[    0.007584] ACPI: BGRT 0x0000000076F05000 000038 (v01 HYGON  Hygon=20
00000002      01000013)
[    0.007586] ACPI: APIC 0x0000000076F04000 0000DE (v04 HYGON  Hygon=20
00000002      01000013)
[    0.007588] ACPI: WSMT 0x0000000076F03000 000028 (v01 HYGON  Hygon=20
00000002      01000013)
[    0.007599] ACPI: Local APIC address 0xfee00000
[    0.007682] No NUMA configuration found
[    0.007683] Faking a node at [mem 0x0000000000000000-0x0000000277effff=
f]
[    0.007695] NODE_DATA(0) allocated [mem 0x277ed5000-0x277efffff]
[    0.007988] Zone ranges:
[    0.007988]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007990]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007991]   Normal   [mem 0x0000000100000000-0x0000000277efffff]
[    0.007991]   Device   empty
[    0.007992] Movable zone start for each node
[    0.007996] Early memory node ranges
[    0.007996]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.007997]   node   0: [mem 0x0000000000100000-0x0000000003ffffff]
[    0.007998]   node   0: [mem 0x0000000004040000-0x0000000005dfffff]
[    0.007998]   node   0: [mem 0x0000000006000000-0x00000000730f5fff]
[    0.007999]   node   0: [mem 0x000000007a9fe000-0x000000007bffffff]
[    0.008000]   node   0: [mem 0x0000000100000000-0x0000000277efffff]
[    0.008361] Zeroed struct page in unavailable ranges: 48042 pages
[    0.008362] Initmem setup node 0 [mem=20
0x0000000000001000-0x0000000277efffff]
[    0.008364] On node 0 totalpages: 2016086
[    0.008365]   DMA zone: 64 pages used for memmap
[    0.008366]   DMA zone: 22 pages reserved
[    0.008367]   DMA zone: 3998 pages, LIFO batch:0
[    0.008430]   DMA32 zone: 7379 pages used for memmap
[    0.008431]   DMA32 zone: 472248 pages, LIFO batch:63
[    0.018824]   Normal zone: 24060 pages used for memmap
[    0.018826]   Normal zone: 1539840 pages, LIFO batch:63
[    0.044509] ACPI: PM-Timer IO Port: 0x808
[    0.044512] ACPI: Local APIC address 0xfee00000
[    0.044520] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.044547] IOAPIC[0]: apic_id 224, version 33, address 0xfec00000,=20
GSI 0-23
[    0.044551] IOAPIC[1]: apic_id 225, version 33, address 0xdfa00000,=20
GSI 24-55
[    0.044553] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.044555] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.044556] ACPI: IRQ0 used by override.
[    0.044557] ACPI: IRQ9 used by override.
[    0.044559] Using ACPI (MADT) for SMP configuration information
[    0.044561] ACPI: HPET id: 0x1d948201 base: 0xfed00000
[    0.044572] e820: update [mem 0x6af85000-0x6afc6fff] usable =3D=3D> re=
served
[    0.044586] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.044625] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.044627] PM: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.044630] PM: Registered nosave memory: [mem 0x04000000-0x0403ffff]
[    0.044631] PM: Registered nosave memory: [mem 0x05e00000-0x05ffffff]
[    0.044634] PM: Registered nosave memory: [mem 0x4e97c000-0x4e97cfff]
[    0.044636] PM: Registered nosave memory: [mem 0x4e9a1000-0x4e9a1fff]
[    0.044636] PM: Registered nosave memory: [mem 0x4e9a2000-0x4e9a2fff]
[    0.044638] PM: Registered nosave memory: [mem 0x4e9cd000-0x4e9cdfff]
[    0.044640] PM: Registered nosave memory: [mem 0x6af85000-0x6afc6fff]
[    0.044643] PM: Registered nosave memory: [mem 0x730f6000-0x76edcfff]
[    0.044643] PM: Registered nosave memory: [mem 0x76edd000-0x76f1cfff]
[    0.044644] PM: Registered nosave memory: [mem 0x76f1d000-0x797fdfff]
[    0.044644] PM: Registered nosave memory: [mem 0x797fe000-0x7a9fdfff]
[    0.044646] PM: Registered nosave memory: [mem 0x7c000000-0x7fffffff]
[    0.044647] PM: Registered nosave memory: [mem 0x80000000-0xdf9fffff]
[    0.044648] PM: Registered nosave memory: [mem 0xdfa00000-0xdfa00fff]
[    0.044648] PM: Registered nosave memory: [mem 0xdfa01000-0xdfa7ffff]
[    0.044649] PM: Registered nosave memory: [mem 0xdfa80000-0xdfafffff]
[    0.044649] PM: Registered nosave memory: [mem 0xdfb00000-0xdfffffff]
[    0.044650] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.044650] PM: Registered nosave memory: [mem 0xf0000000-0xfe9fffff]
[    0.044651] PM: Registered nosave memory: [mem 0xfea00000-0xfeafffff]
[    0.044651] PM: Registered nosave memory: [mem 0xfeb00000-0xfebfffff]
[    0.044652] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.044653] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.044653] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.044654] PM: Registered nosave memory: [mem 0xfed01000-0xfed7ffff]
[    0.044654] PM: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
[    0.044655] PM: Registered nosave memory: [mem 0xfed90000-0xfedbffff]
[    0.044655] PM: Registered nosave memory: [mem 0xfedc0000-0xfedc0fff]
[    0.044656] PM: Registered nosave memory: [mem 0xfedc1000-0xfedc1fff]
[    0.044656] PM: Registered nosave memory: [mem 0xfedc2000-0xfedc5fff]
[    0.044657] PM: Registered nosave memory: [mem 0xfedc6000-0xfedc6fff]
[    0.044657] PM: Registered nosave memory: [mem 0xfedc7000-0xfedc7fff]
[    0.044658] PM: Registered nosave memory: [mem 0xfedc8000-0xfedc8fff]
[    0.044659] PM: Registered nosave memory: [mem 0xfedc9000-0xfedcafff]
[    0.044659] PM: Registered nosave memory: [mem 0xfedcb000-0xfeffffff]
[    0.044660] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.044661] [mem 0x80000000-0xdf9fffff] available for PCI devices
[    0.044662] Booting paravirtualized kernel on bare hardware
[    0.044666] clocksource: refined-jiffies: mask: 0xffffffff=20
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.044675] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16=20
nr_cpu_ids:16 nr_node_ids:1
[    0.045405] percpu: Embedded 55 pages/cpu s188416 r8192 d28672 u262144
[    0.045415] pcpu-alloc: s188416 r8192 d28672 u262144 alloc=3D1*2097152
[    0.045416] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11=20
12 13 14 15
[    0.045461] Built 1 zonelists, mobility grouping on.  Total pages:=20
1984561
[    0.045462] Policy zone: Normal
[    0.045464] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.4.18-151+=20
root=3DUUID=3D8c10b5c5-7cef-466c-acaf-a662a005fbad ro quiet splash=20
loglevel=3D0 thunderbolt.dyndbg=3D+plft=20
resume=3DUUID=3D0f053111-bb39-491e-a173-f534050f8dfd security=3D
[    0.046507] Dentry cache hash table entries: 1048576 (order: 11,=20
8388608 bytes, linear)
[    0.046982] Inode-cache hash table entries: 524288 (order: 10,=20
4194304 bytes, linear)
[    0.047136] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.053851] Calgary: detecting Calgary via BIOS EBDA area
[    0.053853] Calgary: Unable to locate Rio Grande table in EBDA - baili=
ng!
[    0.075029] Memory: 7596232K/8064344K available (14339K kernel code,=20
2477K rwdata, 7288K rodata, 2748K init, 7504K bss, 468112K reserved, 0K=20
cma-reserved)
[    0.075398] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16=
, Nodes=3D1
[    0.075426] ftrace: allocating 45179 entries in 177 pages
[    0.092844] rcu: Hierarchical RCU implementation.
[    0.092845] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to=20
nr_cpu_ids=3D16.
[    0.092846] 	Tasks RCU enabled.
[    0.092847] rcu: RCU calculated value of scheduler-enlistment delay=20
is 25 jiffies.
[    0.092848] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D16
[    0.095629] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16
[    0.108076] random: crng done (trusting CPU's manufacturer)
[    0.108113] Console: colour dummy device 80x25
[    0.108118] printk: console [tty0] enabled
[    0.108142] ACPI: Core revision 20190816
[    0.108299] clocksource: hpet: mask: 0xffffffff max_cycles:=20
0xffffffff, max_idle_ns: 133484873504 ns
[    0.108345] APIC: Switch to symmetric I/O mode setup
[    0.169898] Switched APIC routing to physical flat.
[    0.171138] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.188338] clocksource: tsc-early: mask: 0xffffffffffffffff=20
max_cycles: 0x284cede1728, max_idle_ns: 440795340428 ns
[    0.188342] Calibrating delay loop (skipped), value calculated using=20
timer frequency.. 5591.69 BogoMIPS (lpj=3D11183388)
[    0.188344] pid_max: default: 32768 minimum: 301
[    0.192432] LSM: Security Framework initializing
[    0.192436] KYCP: Initializing.
[    0.192438] KYCP: Initialized successfully.
[    0.192515] Mount-cache hash table entries: 16384 (order: 5, 131072=20
bytes, linear)
[    0.192531] Mountpoint-cache hash table entries: 16384 (order: 5,=20
131072 bytes, linear)
[    0.192863] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.192928] LVT offset 2 assigned for vector 0xf4
[    0.192948] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.192948] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB=
 0
[    0.192952] Spectre V2 : Mitigation: Retpolines
[    0.192953] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling=20
RSB on context switch
[    0.192954] Spectre V2 : Enabling Restricted Speculation for firmware=20
calls
[    0.192954] RETBleed: Mitigation: untrained return thunk
[    0.192956] Spectre V2 : mitigation: Enabling conditional Indirect=20
Branch Prediction Barrier
[    0.192957] Spectre V2 : User space: Mitigation: STIBP always-on=20
protection
[    0.192958] Speculative Store Bypass: Mitigation: Speculative Store=20
Bypass disabled via prctl and seccomp
[    0.194951] Freeing SMP alternatives memory: 40K
[    0.303276] smpboot: CPU0: Hygon C86-4G (OPN:3450M) (family: 0x18,=20
model: 0x10, stepping: 0x0)
[    0.303447] Performance Events: Fam18h core perfctr, HYGON PMU driver.
[    0.303451] ... version:                0
[    0.303452] ... bit width:              48
[    0.303452] ... generic registers:      6
[    0.303453] ... value mask:             0000ffffffffffff
[    0.303453] ... max period:             00007fffffffffff
[    0.303454] ... fixed-purpose events:   0
[    0.303454] ... event mask:             000000000000003f
[    0.303488] rcu: Hierarchical SRCU implementation.
[    0.304031] Driver 'phytium_base_ctrl' was unable to register with=20
bus_type 'platform' because the bus was not initialized.
[    0.304080] NMI watchdog: Enabled. Permanently consumes one hw-PMU=20
counter.
[    0.304296] smp: Bringing up secondary CPUs ...
[    0.304339] x86: Booting SMP configuration:
[    0.304339] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8
[    0.318641] Spectre V2 : Update user space SMT mitigation: STIBP=20
always-on
[    0.320441]   #9 #10 #11 #12 #13 #14 #15
[    0.336360] smp: Brought up 1 node, 16 CPUs
[    0.336361] smpboot: Max logical packages: 1
[    0.336362] smpboot: Total of 16 processors activated (89467.10 BogoMI=
PS)
[    0.338537] devtmpfs: initialized
[    0.338537] x86/mm: Memory block size: 128MB
[    0.338537] PM: Registering ACPI NVS region [mem=20
0x76f1d000-0x797fdfff] (42864640 bytes)
[    0.340578] clocksource: jiffies: mask: 0xffffffff max_cycles:=20
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.340578] futex hash table entries: 4096 (order: 6, 262144 bytes,=20
linear)
[    0.343822] pinctrl core: initialized pinctrl subsystem
[    0.343932] PM: RTC time: 08:23:07, date: 2025-01-02
[    0.344380] NET: Registered protocol family 16
[    0.344488] audit: initializing netlink subsys (disabled)
[    0.344493] audit: type=3D2000 audit(1735806187.180:1):=20
state=3Dinitialized audit_enabled=3D0 res=3D1
[    0.344493] EISA bus registered
[    0.344493] cpuidle: using governor ladder
[    0.344493] cpuidle: using governor menu
[    0.344504] ACPI: bus type PCI registered
[    0.344504] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.344504] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem=20
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.344510] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E=
820
[    0.344520] PCI: Using configuration type 1 for base access
[    0.346647] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pag=
es
[    0.346647] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pag=
es
[    0.348451] ACPI: Added _OSI(Module Device)
[    0.348452] ACPI: Added _OSI(Processor Device)
[    0.348453] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.348453] ACPI: Added _OSI(Processor Aggregator Device)
[    0.348454] ACPI: Added _OSI(Linux-Dell-Video)
[    0.348455] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.348455] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.356707] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.420756] ACPI: EC: EC started
[    0.420757] ACPI: EC: interrupt blocked
[    0.420799] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.420800] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC used to handle=20
transactions
[    0.420801] ACPI: Interpreter enabled
[    0.420824] ACPI: (supports S0 S3 S4 S5)
[    0.420824] ACPI: Using IOAPIC for interrupt routing
[    0.421194] PCI: Using host bridge windows from ACPI; if necessary,=20
use "pci=3Dnocrs" and report a bug
[    0.421477] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.422024] ACPI: Power Resource [P0A0] (on)
[    0.422061] ACPI: Power Resource [P3A0] (off)
[    0.422223] ACPI: Power Resource [P0U0] (on)
[    0.422244] ACPI: Power Resource [P3U0] (off)
[    0.422269] ACPI: Power Resource [P0D0] (on)
[    0.422294] ACPI: Power Resource [P3D0] (off)
[    0.422314] ACPI: Power Resource [P0D1] (on)
[    0.422338] ACPI: Power Resource [P3D1] (off)
[    0.422365] ACPI: Power Resource [P0D2] (on)
[    0.422386] ACPI: Power Resource [P3D2] (off)
[    0.422410] ACPI: Power Resource [P0D3] (on)
[    0.422431] ACPI: Power Resource [P3D3] (off)
[    0.422456] ACPI: Power Resource [P0XH] (on)
[    0.422480] ACPI: Power Resource [P3XH] (off)
[    0.422501] ACPI: Power Resource [P0HI] (on)
[    0.422525] ACPI: Power Resource [P3HI] (off)
[    0.424968] ACPI: Power Resource [P0SA] (on)
[    0.424993] ACPI: Power Resource [P3SA] (on)
[    0.430167] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.430172] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM=20
ClockPM Segments MSI HPX-Type3]
[    0.430396] acpi PNP0A08:00: _OSC: platform does not support=20
[SHPCHotplug AER LTR]
[    0.430609] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME=20
PCIeCapability]
[    0.430822] acpi PNP0A08:00: host bridge window expanded to [io=20
0x03b0-0x03df window]; [io  0x03b0-0x03df window] ignored
[    0.430979] PCI host bridge to bus 0000:00
[    0.430980] pci_bus 0000:00: root bus resource [io  0x0000-0x02e7 wind=
ow]
[    0.430981] pci_bus 0000:00: root bus resource [io  0x0300-0x03af wind=
ow]
[    0.430982] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df wind=
ow]
[    0.430982] pci_bus 0000:00: root bus resource [io  0x0400-0x0cf7 wind=
ow]
[    0.430983] pci_bus 0000:00: root bus resource [io  0x3000-0xffff wind=
ow]
[    0.430984] pci_bus 0000:00: root bus resource [mem=20
0x000a0000-0x000bffff window]
[    0.430985] pci_bus 0000:00: root bus resource [mem=20
0x000c0000-0x000dffff window]
[    0.430986] pci_bus 0000:00: root bus resource [mem=20
0xa8000000-0xb69fffff window]
[    0.430987] pci_bus 0000:00: root bus resource [mem=20
0x33380000000-0x333dfffffff window]
[    0.430988] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.431041] pci 0000:00:00.0: [1d94:14c0] type 00 class 0x060000
[    0.431191] pci 0000:00:00.2: [1d94:149e] type 00 class 0x080600
[    0.431376] pci 0000:00:01.0: [1d94:14c2] type 00 class 0x060000
[    0.431537] pci 0000:00:01.1: [1d94:14c3] type 01 class 0x060400
[    0.431680] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.431840] pci 0000:00:01.2: [1d94:14c3] type 01 class 0x060400
[    0.431981] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.432128] pci 0000:00:01.3: [1d94:14c3] type 01 class 0x060400
[    0.432268] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.432424] pci 0000:00:01.5: [1d94:14c3] type 01 class 0x060400
[    0.432564] pci 0000:00:01.5: PME# supported from D0 D3hot D3cold
[    0.432712] pci 0000:00:01.6: [1d94:14c3] type 01 class 0x060400
[    0.432851] pci 0000:00:01.6: PME# supported from D0 D3hot D3cold
[    0.432979] pci 0000:00:02.0: [1d94:14c2] type 00 class 0x060000
[    0.433129] pci 0000:00:03.0: [1d94:14c2] type 00 class 0x060000
[    0.433283] pci 0000:00:07.0: [1d94:14c2] type 00 class 0x060000
[    0.433444] pci 0000:00:07.1: [1d94:14c4] type 01 class 0x060400
[    0.433509] pci 0000:00:07.1: enabling Extended Tags
[    0.433581] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
[    0.433719] pci 0000:00:08.0: [1d94:14c2] type 00 class 0x060000
[    0.433878] pci 0000:00:08.1: [1d94:14c4] type 01 class 0x060400
[    0.433944] pci 0000:00:08.1: enabling Extended Tags
[    0.434017] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.434165] pci 0000:00:0b.0: [1d94:790b] type 00 class 0x0c0500
[    0.434573] pci 0000:00:0b.3: [1d94:790e] type 00 class 0x060100
[    0.434982] pci 0000:00:18.0: [1d94:14d0] type 00 class 0x060000
[    0.435059] pci 0000:00:18.1: [1d94:14d1] type 00 class 0x060000
[    0.435133] pci 0000:00:18.2: [1d94:14d2] type 00 class 0x060000
[    0.435206] pci 0000:00:18.3: [1d94:14d3] type 00 class 0x060000
[    0.435279] pci 0000:00:18.4: [1d94:14d4] type 00 class 0x060000
[    0.435356] pci 0000:00:18.5: [1d94:14d5] type 00 class 0x060000
[    0.435428] pci 0000:00:18.6: [1d94:14d6] type 00 class 0x060000
[    0.435502] pci 0000:00:18.7: [1d94:14d7] type 00 class 0x060000
[    0.435675] pci 0000:01:00.0: [1b21:2421] type 01 class 0x060400
[    0.435869] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.436051] pci 0000:00:01.1: PCI bridge to [bus 01-44]
[    0.436056] pci 0000:00:01.1:   bridge window [io  0x3000-0xcfff]
[    0.436060] pci 0000:00:01.1:   bridge window [mem 0xb0000000-0xb3ffff=
ff]
[    0.436065] pci 0000:00:01.1:   bridge window [mem=20
0x33380000000-0x333bfffffff 64bit pref]
[    0.436185] pci 0000:02:00.0: [1b21:2423] type 01 class 0x060400
[    0.436396] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.436553] pci 0000:02:01.0: [1b21:2423] type 01 class 0x060400
[    0.436758] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[    0.436918] pci 0000:02:02.0: [1b21:2423] type 01 class 0x060400
[    0.437085] pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
[    0.437219] pci 0000:02:03.0: [1b21:2423] type 01 class 0x060400
[    0.437386] pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
[    0.437535] pci 0000:01:00.0: PCI bridge to [bus 02-2c]
[    0.437542] pci 0000:01:00.0:   bridge window [io  0x3000-0xcfff]
[    0.437546] pci 0000:01:00.0:   bridge window [mem 0xb0000000-0xb27fff=
ff]
[    0.437553] pci 0000:01:00.0:   bridge window [mem=20
0x33380000000-0x333bfffffff 64bit pref]
[    0.437606] pci 0000:02:00.0: PCI bridge to [bus 03-16]
[    0.437613] pci 0000:02:00.0:   bridge window [io  0x7000-0xafff]
[    0.437617] pci 0000:02:00.0:   bridge window [mem 0xb1000000-0xb1ffff=
ff]
[    0.437624] pci 0000:02:00.0:   bridge window [mem=20
0x333a0000000-0x333bfffffff 64bit pref]
[    0.437715] pci 0000:17:00.0: [8086:15ef] type 01 class 0x060400
[    0.438096] pci 0000:17:00.0: supports D1 D2
[    0.438097] pci 0000:17:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    0.438224] pci 0000:17:00.0: 2.000 Gb/s available PCIe bandwidth,=20
limited by 2.5 GT/s PCIe x1 link at 0000:02:01.0 (capable of 31.504 Gb/s=20
with 8.0 GT/s PCIe x4 link)
[    0.438348] pci 0000:02:01.0: PCI bridge to [bus 17-2a]
[    0.438351] pci 0000:02:01.0:   bridge window [io  0x3000-0x6fff]
[    0.438354] pci 0000:02:01.0:   bridge window [mem 0xb0000000-0xb0ffff=
ff]
[    0.438357] pci 0000:02:01.0:   bridge window [mem=20
0x33380000000-0x3339fffffff 64bit pref]
[    0.438450] pci 0000:18:02.0: [8086:15ef] type 01 class 0x060400
[    0.438727] pci 0000:18:02.0: supports D1 D2
[    0.438728] pci 0000:18:02.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    0.438905] pci 0000:18:04.0: [8086:15ef] type 01 class 0x060400
[    0.439184] pci 0000:18:04.0: supports D1 D2
[    0.439184] pci 0000:18:04.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    0.439397] pci 0000:17:00.0: PCI bridge to [bus 18-1a]
[    0.439411] pci 0000:17:00.0:   bridge window [mem 0xb0000000-0xb00fff=
ff]
[    0.439518] pci 0000:19:00.0: [8086:15f0] type 00 class 0x0c0330
[    0.439575] pci 0000:19:00.0: reg 0x10: [mem 0xb0000000-0xb000ffff]
[    0.439872] pci 0000:19:00.0: supports D1 D2
[    0.439872] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    0.440003] pci 0000:19:00.0: 2.000 Gb/s available PCIe bandwidth,=20
limited by 2.5 GT/s PCIe x1 link at 0000:02:01.0 (capable of 31.504 Gb/s=20
with 8.0 GT/s PCIe x4 link)
[    0.440158] pci 0000:18:02.0: PCI bridge to [bus 19]
[    0.440172] pci 0000:18:02.0:   bridge window [mem 0xb0000000-0xb00fff=
ff]
[    0.440250] pci 0000:18:04.0: PCI bridge to [bus 1a]
[    0.440357] pci 0000:2b:00.0: [1b21:2426] type 00 class 0x0c0330
[    0.440375] pci 0000:2b:00.0: reg 0x10: [mem 0xb2400000-0xb2407fff 64b=
it]
[    0.440445] pci 0000:2b:00.0: PME# supported from D0 D3hot D3cold
[    0.440527] pci 0000:02:02.0: PCI bridge to [bus 2b]
[    0.440530] pci 0000:02:02.0:   bridge window [io  0xc000-0xcfff]
[    0.440532] pci 0000:02:02.0:   bridge window [mem 0xb2400000-0xb27fff=
ff]
[    0.440595] pci 0000:2c:00.0: [1b21:2425] type 00 class 0x0c0340
[    0.440612] pci 0000:2c:00.0: reg 0x10: [mem 0xb2000000-0xb203ffff 64b=
it]
[    0.440621] pci 0000:2c:00.0: reg 0x18: [mem 0xb2040000-0xb204ffff 64b=
it]
[    0.440681] pci 0000:2c:00.0: PME# supported from D0 D3hot D3cold
[    0.440786] pci 0000:02:03.0: PCI bridge to [bus 2c]
[    0.440788] pci 0000:02:03.0:   bridge window [io  0xb000-0xbfff]
[    0.440791] pci 0000:02:03.0:   bridge window [mem 0xb2000000-0xb23fff=
ff]
[    0.441805] pci 0000:45:00.0: [1ec8:9810] type 00 class 0x030000
[    0.441834] pci 0000:45:00.0: reg 0x10: [mem 0xa8000000-0xabffffff 64b=
it]
[    0.441845] pci 0000:45:00.0: reg 0x18: [mem=20
0x333c0000000-0x333dfffffff 64bit pref]
[    0.441853] pci 0000:45:00.0: reg 0x20: [io  0xf000-0xf0ff]
[    0.441867] pci 0000:45:00.0: reg 0x30: [mem 0xac000000-0xac07ffff pre=
f]
[    0.441881] pci 0000:45:00.0: BAR 2: assigned to efifb
[    0.441932] pci 0000:45:00.0: supports D1
[    0.441933] pci 0000:45:00.0: PME# supported from D0 D1 D3hot
[    0.442046] pci 0000:00:01.2: PCI bridge to [bus 45]
[    0.442049] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.442051] pci 0000:00:01.2:   bridge window [mem 0xa8000000-0xac0fff=
ff]
[    0.442054] pci 0000:00:01.2:   bridge window [mem=20
0x333c0000000-0x333dfffffff 64bit pref]
[    0.443022] pci 0000:46:00.0: [1e68:8111] type 00 class 0x010802
[    0.443085] pci 0000:46:00.0: reg 0x10: [mem 0xb4800000-0xb4803fff 64b=
it]
[    0.444404] pci 0000:00:01.3: PCI bridge to [bus 46]
[    0.444408] pci 0000:00:01.3:   bridge window [mem 0xb4800000-0xb48fff=
ff]
[    0.444457] pci 0000:47:00.0: [10ec:8168] type 00 class 0x020000
[    0.444480] pci 0000:47:00.0: reg 0x10: [io  0xe000-0xe0ff]
[    0.444501] pci 0000:47:00.0: reg 0x18: [mem 0xb4704000-0xb4704fff 64b=
it]
[    0.444513] pci 0000:47:00.0: reg 0x20: [mem 0xb4700000-0xb4703fff 64b=
it]
[    0.444589] pci 0000:47:00.0: supports D1 D2
[    0.444589] pci 0000:47:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    0.444703] pci 0000:00:01.5: PCI bridge to [bus 47]
[    0.444706] pci 0000:00:01.5:   bridge window [io  0xe000-0xefff]
[    0.444708] pci 0000:00:01.5:   bridge window [mem 0xb4700000-0xb47fff=
ff]
[    0.444759] pci 0000:48:00.0: [10ec:b852] type 00 class 0x028000
[    0.444790] pci 0000:48:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.444819] pci 0000:48:00.0: reg 0x18: [mem 0xb4600000-0xb46fffff 64b=
it]
[    0.444932] pci 0000:48:00.0: PME# supported from D0 D3hot D3cold
[    0.445058] pci 0000:00:01.6: PCI bridge to [bus 48]
[    0.445060] pci 0000:00:01.6:   bridge window [io  0xd000-0xdfff]
[    0.445062] pci 0000:00:01.6:   bridge window [mem 0xb4600000-0xb46fff=
ff]
[    0.445116] pci 0000:49:00.0: [1d94:14c5] type 00 class 0x130000
[    0.445151] pci 0000:49:00.0: enabling Extended Tags
[    0.445234] pci 0000:49:00.2: [1d94:14c6] type 00 class 0x108000
[    0.445252] pci 0000:49:00.2: reg 0x18: [mem 0xb4400000-0xb44fffff]
[    0.445263] pci 0000:49:00.2: reg 0x24: [mem 0xb4502000-0xb4503fff]
[    0.445270] pci 0000:49:00.2: enabling Extended Tags
[    0.445363] pci 0000:49:00.3: [1d94:14d8] type 00 class 0x108000
[    0.445380] pci 0000:49:00.3: reg 0x18: [mem 0xb4300000-0xb43fffff]
[    0.445392] pci 0000:49:00.3: reg 0x24: [mem 0xb4500000-0xb4501fff]
[    0.445399] pci 0000:49:00.3: enabling Extended Tags
[    0.445504] pci 0000:00:07.1: PCI bridge to [bus 49]
[    0.445507] pci 0000:00:07.1:   bridge window [mem 0xb4300000-0xb45fff=
ff]
[    0.445566] pci 0000:4a:00.0: [1d94:14c5] type 00 class 0x130000
[    0.445601] pci 0000:4a:00.0: enabling Extended Tags
[    0.445689] pci 0000:4a:00.1: [1d94:148c] type 00 class 0x0c0330
[    0.445702] pci 0000:4a:00.1: reg 0x10: [mem 0xb4000000-0xb40fffff 64b=
it]
[    0.445723] pci 0000:4a:00.1: enabling Extended Tags
[    0.445754] pci 0000:4a:00.1: PME# supported from D0 D3hot D3cold
[    0.445826] pci 0000:4a:00.2: [1d94:148c] type 00 class 0x0c0330
[    0.445839] pci 0000:4a:00.2: reg 0x10: [mem 0xb4100000-0xb41fffff 64b=
it]
[    0.445860] pci 0000:4a:00.2: enabling Extended Tags
[    0.445891] pci 0000:4a:00.2: PME# supported from D0 D3hot D3cold
[    0.445966] pci 0000:4a:00.6: [1d94:14c9] type 00 class 0x040300
[    0.445977] pci 0000:4a:00.6: reg 0x10: [mem 0xb4200000-0xb4207fff]
[    0.446001] pci 0000:4a:00.6: enabling Extended Tags
[    0.446030] pci 0000:4a:00.6: PME# supported from D0 D3hot D3cold
[    0.446106] pci 0000:00:08.1: PCI bridge to [bus 4a]
[    0.446110] pci 0000:00:08.1:   bridge window [mem 0xb4000000-0xb42fff=
ff]
[    0.446138] pci_bus 0000:00: on NUMA node 0
[    0.447670] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *=
0
[    0.447729] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *=
0
[    0.447787] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *=
0
[    0.447849] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *=
0
[    0.447907] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *=
0
[    0.447965] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *=
0
[    0.448023] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *=
0
[    0.448081] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *=
0
[    0.448368] ACPI: EC: interrupt unblocked
[    0.448369] ACPI: EC: event unblocked
[    0.448376] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.448377] ACPI: EC: GPE=3D0x3
[    0.448378] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC used to handle=20
transactions and events
[    0.448450] iommu: Default domain type: Translated
[    0.448508] libata version 3.00 loaded.
[    0.448508] SCSI subsystem initialized
[    0.449287] pci 0000:45:00.0: vgaarb: VGA device added:=20
decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
[    0.449289] pci 0000:45:00.0: vgaarb: bridge control possible
[    0.449290] pci 0000:45:00.0: vgaarb: setting as boot device
[    0.449290] vgaarb: loaded
[    0.449305] ACPI: bus type USB registered
[    0.449322] usbcore: registered new interface driver usbfs
[    0.449328] usbcore: registered new interface driver hub
[    0.452342] usbcore: registered new device driver usb
[    0.462162] mc: Linux media interface: v0.10
[    0.462168] videodev: Linux video capture interface: v2.00
[    0.462179] pps_core: LinuxPPS API ver. 1 registered
[    0.462180] pps_core: Software ver. 5.3.6 - Copyright 2005-2007=20
Rodolfo Giometti <giometti@linux.it>
[    0.462186] PTP clock support registered
[    0.462212] EDAC MC: Ver: 3.0.0
[    0.464361] Registered efivars operations
[    0.464408] Advanced Linux Sound Architecture Driver Initialized.
[    0.464408] PCI: Using ACPI for IRQ routing
[    0.477609] PCI: pci_cache_line_size set to 64 bytes
[    0.481275] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.481276] e820: reserve RAM buffer [mem 0x05e00000-0x07ffffff]
[    0.481276] e820: reserve RAM buffer [mem 0x4e97c018-0x4fffffff]
[    0.481277] e820: reserve RAM buffer [mem 0x4e9a2018-0x4fffffff]
[    0.481277] e820: reserve RAM buffer [mem 0x6af85000-0x6bffffff]
[    0.481278] e820: reserve RAM buffer [mem 0x730f6000-0x73ffffff]
[    0.481279] e820: reserve RAM buffer [mem 0x277f00000-0x277ffffff]
[    0.484398] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.484400] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.486458] clocksource: Switched to clocksource tsc-early
[    0.497399] VFS: Disk quotas dquot_6.6.0
[    0.497422] VFS: Dquot-cache hash table entries: 512 (order 0, 4096=20
bytes)
[    0.497495] Init box entries under sysfs SUCCESS!
[    0.497497] KYSEC: Init kysecfs SUCCESS!
[    0.497527] pnp: PnP ACPI init
[    0.497724] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.498075] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 PNP030b=20
(active)
[    0.498435] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.498437] system 00:02: [io  0x040b] has been reserved
[    0.498438] system 00:02: [io  0x04d6] has been reserved
[    0.498438] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.498439] system 00:02: [io  0x0c14] has been reserved
[    0.498440] system 00:02: [io  0x0c50-0x0c51] has been reserved
[    0.498441] system 00:02: [io  0x0c52] has been reserved
[    0.498442] system 00:02: [io  0x0c6c] has been reserved
[    0.498443] system 00:02: [io  0x0c6f] has been reserved
[    0.498444] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
[    0.498445] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
[    0.498445] system 00:02: [io  0x0cd4-0x0cd5] has been reserved
[    0.498446] system 00:02: [io  0x0cd6-0x0cd7] has been reserved
[    0.498447] system 00:02: [io  0x0cd8-0x0cdf] has been reserved
[    0.498448] system 00:02: [io  0x0800-0x089f] has been reserved
[    0.498449] system 00:02: [io  0x0b00-0x0b0f] has been reserved
[    0.498450] system 00:02: [io  0x0b20-0x0b3f] has been reserved
[    0.498451] system 00:02: [io  0x0900-0x090f] has been reserved
[    0.498452] system 00:02: [io  0x0910-0x091f] has been reserved
[    0.498453] system 00:02: [mem 0xfec00000-0xfec00fff] could not be=20
reserved
[    0.498454] system 00:02: [mem 0xfec01000-0xfec01fff] has been reserve=
d
[    0.498455] system 00:02: [mem 0xfedc0000-0xfedc0fff] has been reserve=
d
[    0.498456] system 00:02: [mem 0xfee00000-0xfee00fff] has been reserve=
d
[    0.498457] system 00:02: [mem 0xfed80000-0xfed8ffff] could not be=20
reserved
[    0.498458] system 00:02: [mem 0xfed61000-0xfed70fff] has been reserve=
d
[    0.498459] system 00:02: [mem 0xfec10000-0xfec10fff] has been reserve=
d
[    0.498460] system 00:02: [mem 0xff000000-0xffffffff] has been reserve=
d
[    0.498464] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    0.498794] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.499072] pnp: PnP ACPI: found 4 devices
[    0.500264] thermal_sys: Registered thermal governor 'fair_share'
[    0.500265] thermal_sys: Registered thermal governor 'bang_bang'
[    0.500265] thermal_sys: Registered thermal governor 'step_wise'
[    0.500266] thermal_sys: Registered thermal governor 'user_space'
[    0.500266] thermal_sys: Registered thermal governor 'power_allocator'
[    0.504789] clocksource: acpi_pm: mask: 0xffffff max_cycles:=20
0xffffff, max_idle_ns: 2085701024 ns
[    0.504826] pci 0000:18:04.0: bridge window [io  0x1000-0x0fff] to=20
[bus 1a] add_size 1000
[    0.504827] pci 0000:18:04.0: bridge window [mem=20
0x00100000-0x000fffff 64bit pref] to [bus 1a] add_size 200000 add_align=20
100000
[    0.504828] pci 0000:18:04.0: bridge window [mem=20
0x00100000-0x000fffff] to [bus 1a] add_size 200000 add_align 100000
[    0.504830] pci 0000:17:00.0: bridge window [io  0x1000-0x0fff] to=20
[bus 18-1a] add_size 1000
[    0.504832] pci 0000:17:00.0: bridge window [mem=20
0x00100000-0x001fffff 64bit pref] to [bus 18-1a] add_size 200000=20
add_align 100000
[    0.504838] pci 0000:02:00.0: PCI bridge to [bus 03-16]
[    0.504841] pci 0000:02:00.0:   bridge window [io  0x7000-0xafff]
[    0.504845] pci 0000:02:00.0:   bridge window [mem 0xb1000000-0xb1ffff=
ff]
[    0.504847] pci 0000:02:00.0:   bridge window [mem=20
0x333a0000000-0x333bfffffff 64bit pref]
[    0.504853] pci 0000:17:00.0: BAR 15: assigned [mem=20
0x33380000000-0x333802fffff 64bit pref]
[    0.504855] pci 0000:17:00.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.504857] pci 0000:18:04.0: BAR 14: no space for [mem size 0x0020000=
0]
[    0.504858] pci 0000:18:04.0: BAR 14: failed to assign [mem size=20
0x00200000]
[    0.504859] pci 0000:18:04.0: BAR 15: assigned [mem=20
0x33380000000-0x333801fffff 64bit pref]
[    0.504860] pci 0000:18:04.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.504862] pci 0000:18:04.0: BAR 14: no space for [mem size 0x0020000=
0]
[    0.504862] pci 0000:18:04.0: BAR 14: failed to assign [mem size=20
0x00200000]
[    0.504863] pci 0000:18:02.0: PCI bridge to [bus 19]
[    0.504871] pci 0000:18:02.0:   bridge window [mem 0xb0000000-0xb00fff=
ff]
[    0.504885] pci 0000:18:04.0: PCI bridge to [bus 1a]
[    0.504888] pci 0000:18:04.0:   bridge window [io  0x3000-0x3fff]
[    0.504899] pci 0000:18:04.0:   bridge window [mem=20
0x33380000000-0x333801fffff 64bit pref]
[    0.504909] pci 0000:17:00.0: PCI bridge to [bus 18-1a]
[    0.504912] pci 0000:17:00.0:   bridge window [io  0x3000-0x3fff]
[    0.504919] pci 0000:17:00.0:   bridge window [mem 0xb0000000-0xb00fff=
ff]
[    0.504924] pci 0000:17:00.0:   bridge window [mem=20
0x33380000000-0x333802fffff 64bit pref]
[    0.504933] pci 0000:02:01.0: PCI bridge to [bus 17-2a]
[    0.504935] pci 0000:02:01.0:   bridge window [io  0x3000-0x6fff]
[    0.504938] pci 0000:02:01.0:   bridge window [mem 0xb0000000-0xb0ffff=
ff]
[    0.504940] pci 0000:02:01.0:   bridge window [mem=20
0x33380000000-0x3339fffffff 64bit pref]
[    0.504945] pci 0000:02:02.0: PCI bridge to [bus 2b]
[    0.504946] pci 0000:02:02.0:   bridge window [io  0xc000-0xcfff]
[    0.504949] pci 0000:02:02.0:   bridge window [mem 0xb2400000-0xb27fff=
ff]
[    0.504954] pci 0000:02:03.0: PCI bridge to [bus 2c]
[    0.504956] pci 0000:02:03.0:   bridge window [io  0xb000-0xbfff]
[    0.504959] pci 0000:02:03.0:   bridge window [mem 0xb2000000-0xb23fff=
ff]
[    0.504964] pci 0000:01:00.0: PCI bridge to [bus 02-2c]
[    0.504966] pci 0000:01:00.0:   bridge window [io  0x3000-0xcfff]
[    0.504969] pci 0000:01:00.0:   bridge window [mem 0xb0000000-0xb27fff=
ff]
[    0.504971] pci 0000:01:00.0:   bridge window [mem=20
0x33380000000-0x333bfffffff 64bit pref]
[    0.504975] pci 0000:00:01.1: PCI bridge to [bus 01-44]
[    0.504976] pci 0000:00:01.1:   bridge window [io  0x3000-0xcfff]
[    0.504979] pci 0000:00:01.1:   bridge window [mem 0xb0000000-0xb3ffff=
ff]
[    0.504980] pci 0000:00:01.1:   bridge window [mem=20
0x33380000000-0x333bfffffff 64bit pref]
[    0.504983] pci 0000:00:01.2: PCI bridge to [bus 45]
[    0.504985] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.504987] pci 0000:00:01.2:   bridge window [mem 0xa8000000-0xac0fff=
ff]
[    0.504989] pci 0000:00:01.2:   bridge window [mem=20
0x333c0000000-0x333dfffffff 64bit pref]
[    0.504992] pci 0000:00:01.3: PCI bridge to [bus 46]
[    0.504994] pci 0000:00:01.3:   bridge window [mem 0xb4800000-0xb48fff=
ff]
[    0.504998] pci 0000:00:01.5: PCI bridge to [bus 47]
[    0.504999] pci 0000:00:01.5:   bridge window [io  0xe000-0xefff]
[    0.505001] pci 0000:00:01.5:   bridge window [mem 0xb4700000-0xb47fff=
ff]
[    0.505005] pci 0000:00:01.6: PCI bridge to [bus 48]
[    0.505006] pci 0000:00:01.6:   bridge window [io  0xd000-0xdfff]
[    0.505009] pci 0000:00:01.6:   bridge window [mem 0xb4600000-0xb46fff=
ff]
[    0.505013] pci 0000:00:07.1: PCI bridge to [bus 49]
[    0.505015] pci 0000:00:07.1:   bridge window [mem 0xb4300000-0xb45fff=
ff]
[    0.505019] pci 0000:00:08.1: PCI bridge to [bus 4a]
[    0.505021] pci 0000:00:08.1:   bridge window [mem 0xb4000000-0xb42fff=
ff]
[    0.505026] pci_bus 0000:00: resource 4 [io  0x0000-0x02e7 window]
[    0.505027] pci_bus 0000:00: resource 5 [io  0x0300-0x03af window]
[    0.505028] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.505029] pci_bus 0000:00: resource 7 [io  0x0400-0x0cf7 window]
[    0.505030] pci_bus 0000:00: resource 8 [io  0x3000-0xffff window]
[    0.505031] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff=20
window]
[    0.505033] pci_bus 0000:00: resource 10 [mem 0x000c0000-0x000dffff=20
window]
[    0.505034] pci_bus 0000:00: resource 11 [mem 0xa8000000-0xb69fffff=20
window]
[    0.505035] pci_bus 0000:00: resource 12 [mem=20
0x33380000000-0x333dfffffff window]
[    0.505036] pci_bus 0000:01: resource 0 [io  0x3000-0xcfff]
[    0.505036] pci_bus 0000:01: resource 1 [mem 0xb0000000-0xb3ffffff]
[    0.505037] pci_bus 0000:01: resource 2 [mem=20
0x33380000000-0x333bfffffff 64bit pref]
[    0.505038] pci_bus 0000:02: resource 0 [io  0x3000-0xcfff]
[    0.505039] pci_bus 0000:02: resource 1 [mem 0xb0000000-0xb27fffff]
[    0.505040] pci_bus 0000:02: resource 2 [mem=20
0x33380000000-0x333bfffffff 64bit pref]
[    0.505041] pci_bus 0000:03: resource 0 [io  0x7000-0xafff]
[    0.505042] pci_bus 0000:03: resource 1 [mem 0xb1000000-0xb1ffffff]
[    0.505042] pci_bus 0000:03: resource 2 [mem=20
0x333a0000000-0x333bfffffff 64bit pref]
[    0.505043] pci_bus 0000:17: resource 0 [io  0x3000-0x6fff]
[    0.505044] pci_bus 0000:17: resource 1 [mem 0xb0000000-0xb0ffffff]
[    0.505045] pci_bus 0000:17: resource 2 [mem=20
0x33380000000-0x3339fffffff 64bit pref]
[    0.505046] pci_bus 0000:18: resource 0 [io  0x3000-0x3fff]
[    0.505046] pci_bus 0000:18: resource 1 [mem 0xb0000000-0xb00fffff]
[    0.505047] pci_bus 0000:18: resource 2 [mem=20
0x33380000000-0x333802fffff 64bit pref]
[    0.505048] pci_bus 0000:19: resource 1 [mem 0xb0000000-0xb00fffff]
[    0.505049] pci_bus 0000:1a: resource 0 [io  0x3000-0x3fff]
[    0.505050] pci_bus 0000:1a: resource 2 [mem=20
0x33380000000-0x333801fffff 64bit pref]
[    0.505050] pci_bus 0000:2b: resource 0 [io  0xc000-0xcfff]
[    0.505051] pci_bus 0000:2b: resource 1 [mem 0xb2400000-0xb27fffff]
[    0.505052] pci_bus 0000:2c: resource 0 [io  0xb000-0xbfff]
[    0.505053] pci_bus 0000:2c: resource 1 [mem 0xb2000000-0xb23fffff]
[    0.505054] pci_bus 0000:45: resource 0 [io  0xf000-0xffff]
[    0.505054] pci_bus 0000:45: resource 1 [mem 0xa8000000-0xac0fffff]
[    0.505055] pci_bus 0000:45: resource 2 [mem=20
0x333c0000000-0x333dfffffff 64bit pref]
[    0.505056] pci_bus 0000:46: resource 1 [mem 0xb4800000-0xb48fffff]
[    0.505057] pci_bus 0000:47: resource 0 [io  0xe000-0xefff]
[    0.505058] pci_bus 0000:47: resource 1 [mem 0xb4700000-0xb47fffff]
[    0.505059] pci_bus 0000:48: resource 0 [io  0xd000-0xdfff]
[    0.505059] pci_bus 0000:48: resource 1 [mem 0xb4600000-0xb46fffff]
[    0.505060] pci_bus 0000:49: resource 1 [mem 0xb4300000-0xb45fffff]
[    0.505061] pci_bus 0000:4a: resource 1 [mem 0xb4000000-0xb42fffff]
[    0.505160] NET: Registered protocol family 2
[    0.505277] IP idents hash table entries: 131072 (order: 8, 1048576=20
bytes, linear)
[    0.506045] tcp_listen_portaddr_hash hash table entries: 4096 (order:=20
4, 65536 bytes, linear)
[    0.506057] TCP established hash table entries: 65536 (order: 7,=20
524288 bytes, linear)
[    0.506132] TCP bind hash table entries: 65536 (order: 8, 1048576=20
bytes, linear)
[    0.506258] TCP: Hash tables configured (established 65536 bind 65536)
[    0.506291] UDP hash table entries: 4096 (order: 5, 131072 bytes, line=
ar)
[    0.506311] UDP-Lite hash table entries: 4096 (order: 5, 131072=20
bytes, linear)
[    0.506379] NET: Registered protocol family 1
[    0.506383] NET: Registered protocol family 44
[    0.508835] PCI: CLS 64 bytes, default 64
[    0.508865] Trying to unpack rootfs image as initramfs...
[    0.659768] Freeing initrd memory: 71884K
[    0.659836] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters=20
supported
[    0.660195] pci 0000:00:01.0: Adding to iommu group 0
[    0.660339] pci 0000:00:01.1: Adding to iommu group 1
[    0.660482] pci 0000:00:01.2: Adding to iommu group 2
[    0.660631] pci 0000:00:01.3: Adding to iommu group 3
[    0.660769] pci 0000:00:01.5: Adding to iommu group 4
[    0.660913] pci 0000:00:01.6: Adding to iommu group 5
[    0.661044] pci 0000:00:02.0: Adding to iommu group 6
[    0.661185] pci 0000:00:03.0: Adding to iommu group 7
[    0.661322] pci 0000:00:07.0: Adding to iommu group 8
[    0.661473] pci 0000:00:07.1: Adding to iommu group 9
[    0.661620] pci 0000:00:08.0: Adding to iommu group 10
[    0.661765] pci 0000:00:08.1: Adding to iommu group 11
[    0.661898] pci 0000:00:0b.0: Adding to iommu group 12
[    0.661922] pci 0000:00:0b.3: Adding to iommu group 12
[    0.662089] pci 0000:00:18.0: Adding to iommu group 13
[    0.662112] pci 0000:00:18.1: Adding to iommu group 13
[    0.662135] pci 0000:00:18.2: Adding to iommu group 13
[    0.662157] pci 0000:00:18.3: Adding to iommu group 13
[    0.662179] pci 0000:00:18.4: Adding to iommu group 13
[    0.662201] pci 0000:00:18.5: Adding to iommu group 13
[    0.662224] pci 0000:00:18.6: Adding to iommu group 13
[    0.662246] pci 0000:00:18.7: Adding to iommu group 13
[    0.662390] pci 0000:01:00.0: Adding to iommu group 14
[    0.662537] pci 0000:02:00.0: Adding to iommu group 15
[    0.662674] pci 0000:02:01.0: Adding to iommu group 16
[    0.662822] pci 0000:02:02.0: Adding to iommu group 17
[    0.662954] pci 0000:02:03.0: Adding to iommu group 18
[    0.663010] pci 0000:17:00.0: Adding to iommu group 16
[    0.663061] pci 0000:18:02.0: Adding to iommu group 16
[    0.663111] pci 0000:18:04.0: Adding to iommu group 16
[    0.663195] pci 0000:19:00.0: Adding to iommu group 16
[    0.663221] pci 0000:2b:00.0: Adding to iommu group 17
[    0.663252] pci 0000:2c:00.0: Adding to iommu group 18
[    0.664346] pci 0000:45:00.0: Adding to iommu group 19
[    0.665408] pci 0000:46:00.0: Adding to iommu group 20
[    0.665565] pci 0000:47:00.0: Adding to iommu group 21
[    0.665707] pci 0000:48:00.0: Adding to iommu group 22
[    0.665857] pci 0000:49:00.0: Adding to iommu group 23
[    0.666021] pci 0000:49:00.2: Adding to iommu group 24
[    0.666163] pci 0000:49:00.3: Adding to iommu group 25
[    0.666328] pci 0000:4a:00.0: Adding to iommu group 26
[    0.666470] pci 0000:4a:00.1: Adding to iommu group 27
[    0.666624] pci 0000:4a:00.2: Adding to iommu group 28
[    0.666769] pci 0000:4a:00.6: Adding to iommu group 29
[    0.667022] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.667023] pci 0000:00:00.2: AMD-Vi: Extended features=20
(0x41f73ef22294ade):
[    0.667023]  PPR X2APIC NX GT IA GA PC GA_vAPIC
[    0.667026] AMD-Vi: Interrupt remapping enabled
[    0.667026] AMD-Vi: Virtual APIC enabled
[    0.667026] AMD-Vi: X2APIC enabled
[    0.667176] AMD-Vi: Lazy IO/TLB flushing enabled
[    0.668315] amd_uncore: HYGON NB counters detected
[    0.668317] amd_uncore: HYGON LLC counters detected
[    0.668529] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4=20
counters/bank).
[    0.668585] check: Scanning for low memory corruption every 60 seconds
[    0.669082] Initialise system trusted keyrings
[    0.669106] Key type blacklist registered
[    0.669146] workingset: timestamp_bits=3D36 max_order=3D21 bucket_orde=
r=3D0
[    0.670534] zbud: loaded
[    0.671023] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.671184] fuse: init (API version 7.31)
[    0.676372] Key type asymmetric registered
[    0.676374] Asymmetric key parser 'x509' registered
[    0.676380] Block layer SCSI generic (bsg) driver version 0.4 loaded=20
(major 243)
[    0.676443] io scheduler mq-deadline registered
[    0.676491] io scheduler bfq registered
[    0.677462] gpio gpiochip1: (HYGO0030:01): detected irqchip that is=20
shared with multiple gpiochips: please fix the driver.
[    0.677636] pcieport 0000:00:01.1: PME: Signaling with IRQ 30
[    0.677803] pcieport 0000:00:01.2: PME: Signaling with IRQ 31
[    0.677974] pcieport 0000:00:01.3: PME: Signaling with IRQ 32
[    0.678145] pcieport 0000:00:01.5: PME: Signaling with IRQ 33
[    0.678303] pcieport 0000:00:01.6: PME: Signaling with IRQ 34
[    0.678549] pcieport 0000:00:07.1: PME: Signaling with IRQ 36
[    0.678712] pcieport 0000:00:08.1: PME: Signaling with IRQ 37
[    0.679032] pcieport 0000:02:00.0: pciehp: Slot #0 AttnBtn- PwrCtrl-=20
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[    0.679291] pcieport 0000:02:01.0: pciehp: Slot #0 AttnBtn- PwrCtrl-=20
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[    0.680438] pcieport 0000:18:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl-=20
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[    0.680708] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
.4
[    0.680762] efifb: probing for efifb
[    0.680777] efifb: framebuffer at 0x333c0000000, using 3072k, total 30=
72k
[    0.680778] efifb: mode is 1024x768x32, linelength=3D4096, pages=3D1
[    0.680778] efifb: scrolling: redraw
[    0.680779] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.680859] Console: switching to colour frame buffer device 128x48
[    0.683348] fb0: EFI VGA frame buffer device
[    0.683799] ACPI: AC Adapter [ADP1] (on-line)
[    0.683848] input: Lid Switch as=20
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:39/PNP0C09:00/PNP0C0D:=
00/input/input0
[    0.683862] ACPI: Lid Switch [LID0]
[    0.683887] input: Power Button as=20
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.683901] ACPI: Power Button [PWRB]
[    0.683925] input: Power Button as=20
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.683954] ACPI: Power Button [PWRF]
[    0.684830] battery: ACPI: Battery Slot [BAT1] (battery absent)
[    0.684920] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.707343] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
)=20
is a 16550A
[    0.708555] Linux agpgart interface v0.103
[    0.711361] loop: module loaded
[    0.711538] libphy: Fixed MDIO Bus: probed
[    0.711539] tun: Universal TUN/TAP device driver, 1.6
[    0.711563] PPP generic driver version 2.4.2
[    0.711607] VFIO - User Level meta-driver version: 0.3
[    0.711653] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.711656] ehci-pci: EHCI PCI platform driver
[    0.711664] ehci-platform: EHCI generic platform driver
[    0.711670] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.711671] ohci-pci: OHCI PCI platform driver
[    0.711677] ohci-platform: OHCI generic platform driver
[    0.711682] uhci_hcd: USB Universal Host Controller Interface driver
[    0.711781] xhci_hcd 0000:19:00.0: xHCI Host Controller
[    0.711787] xhci_hcd 0000:19:00.0: new USB bus registered, assigned=20
bus number 1
[    0.712983] xhci_hcd 0000:19:00.0: hcc params 0x200077c1 hci version=20
0x110 quirks 0x0000000200009810
[    0.713369] xhci_hcd 0000:19:00.0: xHCI Host Controller
[    0.713371] xhci_hcd 0000:19:00.0: new USB bus registered, assigned=20
bus number 2
[    0.713373] xhci_hcd 0000:19:00.0: Host supports USB 3.1 Enhanced=20
SuperSpeed
[    0.713419] usb usb1: New USB device found, idVendor=3D1d6b,=20
idProduct=3D0002, bcdDevice=3D 5.04
[    0.713420] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    0.713421] usb usb1: Product: xHCI Host Controller
[    0.713422] usb usb1: Manufacturer: Linux 5.4.18-151+ xhci-hcd
[    0.713422] usb usb1: SerialNumber: 0000:19:00.0
[    0.713499] hub 1-0:1.0: USB hub found
[    0.713509] hub 1-0:1.0: 2 ports detected
[    0.713633] usb usb2: New USB device found, idVendor=3D1d6b,=20
idProduct=3D0003, bcdDevice=3D 5.04
[    0.713635] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    0.713635] usb usb2: Product: xHCI Host Controller
[    0.713636] usb usb2: Manufacturer: Linux 5.4.18-151+ xhci-hcd
[    0.713637] usb usb2: SerialNumber: 0000:19:00.0
[    0.713698] hub 2-0:1.0: USB hub found
[    0.713712] hub 2-0:1.0: 2 ports detected
[    0.713845] xhci_hcd 0000:2b:00.0: xHCI Host Controller
[    0.713852] xhci_hcd 0000:2b:00.0: new USB bus registered, assigned=20
bus number 3
[    0.716463] xhci_hcd 0000:2b:00.0: hcc params 0x0200ef81 hci version=20
0x120 quirks 0x0000000240000010
[    0.716752] xhci_hcd 0000:2b:00.0: xHCI Host Controller
[    0.716753] xhci_hcd 0000:2b:00.0: new USB bus registered, assigned=20
bus number 4
[    0.716755] xhci_hcd 0000:2b:00.0: Host supports USB 3.2 Enhanced=20
SuperSpeed
[    0.716788] usb usb3: New USB device found, idVendor=3D1d6b,=20
idProduct=3D0002, bcdDevice=3D 5.04
[    0.716789] usb usb3: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    0.716790] usb usb3: Product: xHCI Host Controller
[    0.716790] usb usb3: Manufacturer: Linux 5.4.18-151+ xhci-hcd
[    0.716791] usb usb3: SerialNumber: 0000:2b:00.0
[    0.716861] hub 3-0:1.0: USB hub found
[    0.716866] hub 3-0:1.0: 2 ports detected
[    0.717500] usb usb4: We don't know the algorithms for LPM for this=20
host, disabling LPM.
[    0.717516] usb usb4: New USB device found, idVendor=3D1d6b,=20
idProduct=3D0003, bcdDevice=3D 5.04
[    0.717520] usb usb4: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    0.717521] usb usb4: Product: xHCI Host Controller
[    0.717522] usb usb4: Manufacturer: Linux 5.4.18-151+ xhci-hcd
[    0.717522] usb usb4: SerialNumber: 0000:2b:00.0
[    0.717583] hub 4-0:1.0: USB hub found
[    0.717588] hub 4-0:1.0: 2 ports detected
[    0.718258] xhci_hcd 0000:4a:00.1: xHCI Host Controller
[    0.718262] xhci_hcd 0000:4a:00.1: new USB bus registered, assigned=20
bus number 5
[    0.718391] xhci_hcd 0000:4a:00.1: hcc params 0x0130ffc5 hci version=20
0x110 quirks 0x0000000000000010
[    0.718661] xhci_hcd 0000:4a:00.1: xHCI Host Controller
[    0.718663] xhci_hcd 0000:4a:00.1: new USB bus registered, assigned=20
bus number 6
[    0.718664] xhci_hcd 0000:4a:00.1: Host supports USB 3.1 Enhanced=20
SuperSpeed
[    0.718688] usb usb5: New USB device found, idVendor=3D1d6b,=20
idProduct=3D0002, bcdDevice=3D 5.04
[    0.718689] usb usb5: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    0.718689] usb usb5: Product: xHCI Host Controller
[    0.718690] usb usb5: Manufacturer: Linux 5.4.18-151+ xhci-hcd
[    0.718691] usb usb5: SerialNumber: 0000:4a:00.1
[    0.718745] hub 5-0:1.0: USB hub found
[    0.718751] hub 5-0:1.0: 6 ports detected
[    0.718856] usb usb6: We don't know the algorithms for LPM for this=20
host, disabling LPM.
[    0.718871] usb usb6: New USB device found, idVendor=3D1d6b,=20
idProduct=3D0003, bcdDevice=3D 5.04
[    0.718872] usb usb6: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    0.718873] usb usb6: Product: xHCI Host Controller
[    0.718873] usb usb6: Manufacturer: Linux 5.4.18-151+ xhci-hcd
[    0.718874] usb usb6: SerialNumber: 0000:4a:00.1
[    0.718935] hub 6-0:1.0: USB hub found
[    0.718943] hub 6-0:1.0: 4 ports detected
[    0.719075] xhci_hcd 0000:4a:00.2: xHCI Host Controller
[    0.719078] xhci_hcd 0000:4a:00.2: new USB bus registered, assigned=20
bus number 7
[    0.719210] xhci_hcd 0000:4a:00.2: hcc params 0x0130ffc5 hci version=20
0x110 quirks 0x0000000000000010
[    0.719486] xhci_hcd 0000:4a:00.2: xHCI Host Controller
[    0.719488] xhci_hcd 0000:4a:00.2: new USB bus registered, assigned=20
bus number 8
[    0.719490] xhci_hcd 0000:4a:00.2: Host supports USB 3.0 SuperSpeed
[    0.719513] usb usb7: New USB device found, idVendor=3D1d6b,=20
idProduct=3D0002, bcdDevice=3D 5.04
[    0.719514] usb usb7: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    0.719514] usb usb7: Product: xHCI Host Controller
[    0.719515] usb usb7: Manufacturer: Linux 5.4.18-151+ xhci-hcd
[    0.719516] usb usb7: SerialNumber: 0000:4a:00.2
[    0.719577] hub 7-0:1.0: USB hub found
[    0.719583] hub 7-0:1.0: 6 ports detected
[    0.719709] usb usb8: We don't know the algorithms for LPM for this=20
host, disabling LPM.
[    0.719724] usb usb8: New USB device found, idVendor=3D1d6b,=20
idProduct=3D0003, bcdDevice=3D 5.04
[    0.719725] usb usb8: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    0.719726] usb usb8: Product: xHCI Host Controller
[    0.719727] usb usb8: Manufacturer: Linux 5.4.18-151+ xhci-hcd
[    0.719727] usb usb8: SerialNumber: 0000:4a:00.2
[    0.719787] hub 8-0:1.0: USB hub found
[    0.719792] hub 8-0:1.0: 4 ports detected
[    0.719908] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 ir=
q 1
[    0.719908] i8042: PNP: PS/2 appears to have AUX port disabled, if=20
this is incorrect please boot with i8042.nopnp
[    0.720999] i8042: Warning: Keylock active
[    0.723957] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.724021] mousedev: PS/2 mouse device common for all mice
[    0.724990] rtc_cmos 00:00: RTC can wake from S4
[    0.725251] rtc_cmos 00:00: registered as rtc0
[    0.725301] rtc_cmos 00:00: setting system clock to=20
2025-01-02T08:23:07 UTC (1735806187)
[    0.725312] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes=20
nvram, hpet irqs
[    0.725336] i2c /dev entries driver
[    0.725446] device-mapper: uevent: version 1.0.3
[    0.725492] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16)=20
initialised: dm-devel@redhat.com
[    0.725504] platform eisa.0: Probing EISA bus 0
[    0.725509] platform eisa.0: EISA: Cannot allocate resource for mainbo=
ard
[    0.725518] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.725519] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.725520] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.725521] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.725522] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.725522] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.725523] platform eisa.0: EISA: Detected 0 cards
[    0.725627] ledtrig-cpu: registered to indicate activity on CPUs
[    0.725630] EFI Variables Facility v0.08 2004-May-17
[    0.726554] ccp 0000:49:00.2: no command queues available
[    0.726558] ccp 0000:49:00.2: psp: unable to access the device: you=20
might be running a broken BIOS.
[    0.726957] ccp 0000:49:00.3: ccp enabled
[    0.727262] drop_monitor: Initializing network drop monitor service
[    0.727459] NET: Registered protocol family 10
[    0.732998] input: AT Translated Set 2 keyboard as=20
/devices/platform/i8042/serio0/input/input3
[    0.733207] Segment Routing with IPv6
[    0.733222] NET: Registered protocol family 17
[    0.733256] Key type dns_resolver registered
[    0.734041] RAS: Correctable Errors collector initialized.
[    0.734046] IPI shorthand broadcast: enabled
[    0.734061] sched_clock: Marking stable (665472838,=20
68476011)->(739688286, -5739437)
[    0.734114] registered taskstats version 1
[    0.734122] Loading compiled-in X.509 certificates
[    0.735492] Loaded X.509 cert 'Build time autogenerated kernel key:=20
6a00a5e2caddc1460237269f8de014a8ff3e38a7'
[    0.735521] zswap: loaded using pool lzo/zbud
[    0.735644] Key type ._fscrypt registered
[    0.735644] Key type .fscrypt registered
[    0.740564] Key type big_key registered
[    0.742993] Key type encrypted registered
[    0.742997] ima: No TPM chip found, activating TPM-bypass!
[    0.743003] ima: Allocated hash algorithm: sha256
[    0.743009] ima: No architecture policies found
[    0.743013] evm: Initialising EVM extended attributes:
[    0.743014] evm: security.selinux
[    0.743014] evm: security.apparmor
[    0.743015] evm: security.ima
[    0.743015] evm: security.capability
[    0.743015] evm: HMAC attrs: 0x1
[    0.743024] KYCP: Init kycp entries under securityfs SUCCESS!
[    0.743513] PM:   Magic number: 9:786:370
[    0.743953] acpi_cpufreq: overriding BIOS provided _PSD data
[    0.744579] ALSA device list:
[    0.744580]   No soundcards found.
[    0.746958] Freeing unused decrypted memory: 2036K
[    0.747292] Freeing unused kernel image memory: 2748K
[    0.761637] Write protecting the kernel read-only data: 24576k
[    0.762044] Freeing unused kernel image memory: 2008K
[    0.762188] Freeing unused kernel image memory: 904K
[    0.773079] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.773084] Run /init as init process
[    0.834450] hidraw: raw HID events driver (C) Jiri Kosina
[    0.839470] i2c_hid i2c-BLTP7853:00: supply vdd not found, using=20
dummy regulator
[    0.839480] i2c_hid i2c-BLTP7853:00: supply vddl not found, using=20
dummy regulator
[    0.839531] ACPI: Video Device [EUMA] (multi-head: yes  rom: no=20
post: no)
[    0.842171] acpi device:0f: registered as cooling_device16
[    0.842249] input: Video Bus as=20
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0e/LNXVIDEO:00/input/i=
nput4
[    0.851489] nvme nvme0: pci function 0000:46:00.0
[    0.856104] cryptd: max_cpu_qlen set to 1000
[    0.865674] libphy: r8169: probed
[    0.865855] AVX2 version of gcm_enc/dec engaged.
[    0.865856] AES CTR mode by8 optimization enabled
[    0.865976] r8169 0000:47:00.0 eth0: RTL8168h/8111h,=20
dc:36:43:94:de:51, XID 541, IRQ 79
[    0.865979] r8169 0000:47:00.0 eth0: jumbo features [frames: 9200=20
bytes, tx checksumming: ko]
[    0.877195] r8169 0000:47:00.0 enp71s0: renamed from eth0
[    0.877540] input: BLTP7853:00 347D:7845 Mouse as=20
/devices/platform/HYGO0010:00/i2c-0/i2c-BLTP7853:00/0018:347D:7845.0001/i=
nput/input5
[    0.877608] input: BLTP7853:00 347D:7845 Touchpad as=20
/devices/platform/HYGO0010:00/i2c-0/i2c-BLTP7853:00/0018:347D:7845.0001/i=
nput/input6
[    0.877660] hid-generic 0018:347D:7845.0001: input,hidraw0: I2C HID=20
v1.00 Mouse [BLTP7853:00 347D:7845] on i2c-BLTP7853:00
[    0.902775] fantgpu: loading out-of-tree module taints kernel.
[    0.904465] fantgpu: module verification failed: signature and/or=20
required key missing - tainting kernel
[    0.911698] fant-drv 0000:45:00.0:=20
[pcie][fantgpu_pci_probe:1415]vendor: 1ec8, device: 9810
[    0.919673] checking generic (333c0000000 300000) vs hw (0=20
ffffffffffffffff)
[    0.919674] fb0: switching to fantdrmfb from EFI VGA
[    0.919728] Console: switching to colour dummy device 80x25
[    0.920853] fant-drv 0000:45:00.0:=20
[pcie][hw_check_notice:1148]pcie_stat: 0x309, ddr_stat: 0x4,=20
dbg_reserved_6: 0x1
[    0.921892] fant-drv 0000:45:00.0:=20
[hal][hal_mcufw_status_check:3539]ddr init f_count:0 and=20
paddr:00000333c0d031fa, ddr retrain count:0 and paddr:00000333c0d031f8,=20
pcie_stat: 0x309, ddr_stat: 0x4, dbg_reserved_6: 0x1
[    0.995115] input: BLTP7853:00 347D:7845 Mouse as=20
/devices/platform/HYGO0010:00/i2c-0/i2c-BLTP7853:00/0018:347D:7845.0001/i=
nput/input8
[    0.995163] input: BLTP7853:00 347D:7845 Touchpad as=20
/devices/platform/HYGO0010:00/i2c-0/i2c-BLTP7853:00/0018:347D:7845.0001/i=
nput/input9
[    0.995208] hid-multitouch 0018:347D:7845.0001: input,hidraw0: I2C=20
HID v1.00 Mouse [BLTP7853:00 347D:7845] on i2c-BLTP7853:00
[    1.053033] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    1.057031] usb 5-5: new full-speed USB device number 2 using xhci_hcd
[    1.057037] usb 7-6: new high-speed USB device number 2 using xhci_hcd
[    1.074370] nvme nvme0: missing or invalid SUBNQN field.
[    1.074393] nvme nvme0: Shutdown timeout set to 10 seconds
[    1.075561] nvme nvme0: 8/0/0 default/read/poll queues
[    1.077388]  nvme0n1: p1 p2 p3 p4 p5 p6
[    1.087149] FT_K:  289: Read BVNC 35.4.1632.23 from HW device register=
s
[    1.087154] FT_K:  289: RGX Device registered BVNC 35.4.1632.23 with=20
1 core in the system
[    1.088638] fant-drm fant-drm.14.auto: bound fant-gpu.5.auto (ops=20
s_fantgpu_ft_ops [fantgpu])
[    1.088639] fant-audio fant-audio.13.auto: bind audio device
[    1.089641] fant-drm fant-drm.14.auto: bound fant-audio.13.auto (ops=20
fantaudio_component_ops [fantgpu])
[    1.098476] fant-drm fant-drm.14.auto: bound fant-pdp-dp.6.auto (ops=20
s_fantdpu_dp_ops [fantgpu])
[    1.099838] fant-drm fant-drm.14.auto: bound fant-pdp-hdmi.7.auto=20
(ops s_fant_hdmi_ops [fantgpu])
[    1.101560] fant-drm fant-drm.14.auto: bound fant-pdp-hdmi.8.auto=20
(ops s_fant_hdmi_ops [fantgpu])
[    1.102751] fant-drm fant-drm.14.auto: bound fant-pdp-dpu.9.auto (ops=20
fantdpu_ops [fantgpu])
[    1.103926] fant-drm fant-drm.14.auto: bound fant-pdp-dpu.10.auto=20
(ops fantdpu_ops [fantgpu])
[    1.105103] fant-drm fant-drm.14.auto: bound fant-pdp-dpu.11.auto=20
(ops fantdpu_ops [fantgpu])
[    1.105192] fant-drm fant-drm.14.auto: bound fant-pdp-dpu.12.auto=20
(ops fantdpu_ops [fantgpu])
[    1.107711] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013)=
.
[    1.107712] [drm] No driver support for vblank timestamp query.
[    1.108400] pdev_rsrc is NULL in hal_get_odm_vendor()
[    1.108452] [hwinfo][hwinfo_get_item:965]194 not found in memory!
[    1.108452] [drm] get custom info def duty cycle failed, will use=20
driver default para
[    1.203302] usb 1-1: New USB device found, idVendor=3D2109,=20
idProduct=3D2820, bcdDevice=3D 0.30
[    1.203304] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D0
[    1.203305] usb 1-1: Product: USB2.0 Hub
[    1.203306] usb 1-1: Manufacturer: VIA Labs, Inc.
[    1.204448] hub 1-1:1.0: USB hub found
[    1.204600] hub 1-1:1.0: 4 ports detected
[    1.232579] usb 5-5: New USB device found, idVendor=3D13d3,=20
idProduct=3D3570, bcdDevice=3D 0.00
[    1.232580] usb 5-5: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D3
[    1.232581] usb 5-5: Product: Bluetooth Radio
[    1.232582] usb 5-5: Manufacturer: Realtek
[    1.232583] usb 5-5: SerialNumber: 00e04c000001
[    1.245681] usb 7-6: New USB device found, idVendor=3D2ef4,=20
idProduct=3D207b, bcdDevice=3D 0.06
[    1.245683] usb 7-6: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D3
[    1.245683] usb 7-6: Product: Integrated Camera
[    1.245684] usb 7-6: Manufacturer: SunplusIT Inc
[    1.245685] usb 7-6: SerialNumber: HBW20250723V0
[    1.328549] usb 2-1: new SuperSpeedPlus Gen 2 USB device number 2=20
using xhci_hcd
[    1.340466] usb 6-2: new SuperSpeed Gen 1 USB device number 2 using=20
xhci_hcd
[    1.350403] usb 2-1: New USB device found, idVendor=3D2109,=20
idProduct=3D0820, bcdDevice=3D 0.30
[    1.350404] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D0
[    1.350405] usb 2-1: Product: USB3.0 Hub
[    1.350405] usb 2-1: Manufacturer: VIA Labs, Inc.
[    1.352690] hub 2-1:1.0: USB hub found
[    1.352870] hub 2-1:1.0: 4 ports detected
[    1.360206] [drm] Initialized fantgpu 2.19.236720244 20210625 for=20
0000:45:00.0 on minor 0
[    1.365293] usb 6-2: New USB device found, idVendor=3D0951,=20
idProduct=3D1666, bcdDevice=3D11.00
[    1.365294] usb 6-2: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D3
[    1.365295] usb 6-2: Product: DataTraveler 3.0
[    1.365296] usb 6-2: Manufacturer: Kingston
[    1.365297] usb 6-2: SerialNumber: 408D5C15A0CB21C07905CC3F
[    1.368490] usb-storage 6-2:1.0: USB Mass Storage device detected
[    1.368566] scsi host0: usb-storage 6-2:1.0
[    1.368664] usbcore: registered new interface driver usb-storage
[    1.369493] usbcore: registered new interface driver uas
[    1.492355] usb 5-6: new full-speed USB device number 3 using xhci_hcd
[    1.499750] fbcon: fantgpudrmfb (fb0) is primary device
[    1.654577] usb 5-6: not running at top speed; connect to a high=20
speed hub
[    1.672577] usb 5-6: New USB device found, idVendor=3D2f0a,=20
idProduct=3D8020, bcdDevice=3D63.28
[    1.672578] usb 5-6: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D3
[    1.672579] usb 5-6: Product: PT2887-SS Module
[    1.672580] usb 5-6: Manufacturer: PXAT
[    1.672580] usb 5-6: SerialNumber: 0A3860PNA356
[    1.696352] tsc: Refined TSC clocksource calibration: 2795.802 MHz
[    1.696359] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:=20
0x284cc30ebe3, max_idle_ns: 440795291352 ns
[    1.696388] clocksource: Switched to clocksource tsc
[    1.774303] Console: switching to colour frame buffer device 180x56
[    1.801148] fant-drv 0000:45:00.0: fb0: fantgpudrmfb frame buffer devi=
ce
[    1.932352] usb 1-1.2: new high-speed USB device number 3 using xhci_h=
cd
[    2.082023] usb 1-1.2: New USB device found, idVendor=3D2109,=20
idProduct=3D2817, bcdDevice=3D20.13
[    2.082025] usb 1-1.2: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D3
[    2.082026] usb 1-1.2: Product: USB2.0 Hub
[    2.082027] usb 1-1.2: Manufacturer: VIA Labs, Inc.
[    2.082027] usb 1-1.2: SerialNumber: 000000000
[    2.083623] hub 1-1.2:1.0: USB hub found
[    2.083774] hub 1-1.2:1.0: 5 ports detected
[    2.152945] EXT4-fs (nvme0n1p3): mounted filesystem with ordered data=20
mode. Opts: (null)
[    2.162399] EXT4-fs (nvme0n1p3): re-mounted. Opts: (null)
[    2.164409] usb 2-1.1: new SuperSpeedPlus Gen 2 USB device number 3=20
using xhci_hcd
[    2.171914] EXT4-fs (nvme0n1p3): re-mounted. Opts: (null)
[    2.184862] usb 2-1.1: New USB device found, idVendor=3D0bda,=20
idProduct=3D8153, bcdDevice=3D31.00
[    2.184863] usb 2-1.1: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D6
[    2.184864] usb 2-1.1: Product: USB 10/100/1000 LAN
[    2.184865] usb 2-1.1: Manufacturer: Realtek
[    2.184866] usb 2-1.1: SerialNumber: 00120010F
[    2.223787] EXT4-fs (nvme0n1p3): re-mounted. Opts: (null)
[    2.230518] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data=20
mode. Opts: (null)
[    2.233152] FAT-fs (nvme0n1p1): Volume was not properly unmounted.=20
Some data may be corrupt. Please run fsck.
[    2.244729] EXT4-fs (nvme0n1p5): mounted filesystem with ordered data=20
mode. Opts: (null)
[    2.268499] usb 2-1.2: new SuperSpeedPlus Gen 2 USB device number 4=20
using xhci_hcd
[    2.317271] usb 2-1.2: New USB device found, idVendor=3D2109,=20
idProduct=3D0817, bcdDevice=3D20.13
[    2.317272] usb 2-1.2: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D3
[    2.317274] usb 2-1.2: Product: USB3.0 Hub
[    2.317274] usb 2-1.2: Manufacturer: VIA Labs, Inc.
[    2.317275] usb 2-1.2: SerialNumber: 000000000
[    2.345243] systemd[1]: RTC configured in localtime, applying delta=20
of 480 minutes to system time.
[    2.353668] systemd[1]: Inserted module 'autofs4'
[    2.366218] hub 2-1.2:1.0: USB hub found
[    2.366378] hub 2-1.2:1.0: 4 ports detected
[    2.367048] systemd[1]: systemd 245.4-4kylin3.20k4.19 running in=20
system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP=20
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS=20
+KMOD +IDN2 -IDN +PCRE2 default-hierarchy=3Dhybrid)
[    2.367152] systemd[1]: Detected architecture x86-64.
[    2.385626] systemd[1]: Set hostname to <user-pc>.
[    2.433218] systemd[1]: Configuration file=20
/run/systemd/system/netplan-ovs-cleanup.service is marked=20
world-inaccessible. This has no effect as configuration data is=20
accessible via APIs without restrictions. Proceeding anyway.
[    2.448599] systemd[1]: Configuration file=20
/lib/systemd/system/sw-fant-gl.service is marked executable. Please=20
remove executable permission bits. Proceeding anyway.
[    2.449083] systemd[1]: Configuration file=20
/lib/systemd/system/serviceavserver.service is marked executable. Please=20
remove executable permission bits. Proceeding anyway.
[    2.460211] systemd[1]: Configuration file=20
/lib/systemd/system/kyfs-fuse.service is marked executable. Please=20
remove executable permission bits. Proceeding anyway.
[    2.461051] systemd[1]: Configuration file=20
/lib/systemd/system/kybima.service is marked executable. Please remove=20
executable permission bits. Proceeding anyway.
[    2.485370] systemd[1]: root.mount: Unit is bound to inactive unit=20
dev-nvme0n1p5.device. Stopping, too.
[    2.485406] systemd[1]: home.mount: Unit is bound to inactive unit=20
dev-nvme0n1p5.device. Stopping, too.
[    2.485426] systemd[1]: boot.mount: Unit is bound to inactive unit=20
dev-nvme0n1p2.device. Stopping, too.
[    2.485452] systemd[1]: data.mount: Unit is bound to inactive unit=20
dev-nvme0n1p5.device. Stopping, too.
[    2.487021] systemd[1]: Created slice system-modprobe.slice.
[    2.487209] systemd[1]: Created slice User and Session Slice.
[    2.487256] systemd[1]: Started Forward Password Requests to Wall=20
Directory Watch.
[    2.487623] systemd[1]: Set up automount Arbitrary Executable File=20
Formats File System Automount Point.
[    2.487667] systemd[1]: Reached target User and Group Name Lookups.
[    2.487679] systemd[1]: Reached target Remote File Systems.
[    2.487696] systemd[1]: Reached target Slices.
[    2.487758] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    2.487824] systemd[1]: Listening on LVM2 poll daemon socket.
[    2.487885] systemd[1]: Listening on Syslog Socket.
[    2.488750] systemd[1]: Listening on Process Core Dump Socket.
[    2.488802] systemd[1]: Listening on fsck to fsckd communication Socke=
t.
[    2.488846] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    2.488961] systemd[1]: Listening on Journal Audit Socket.
[    2.489017] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.489089] systemd[1]: Listening on Journal Socket.
[    2.489155] systemd[1]: Listening on udev Control Socket.
[    2.489209] systemd[1]: Listening on udev Kernel Socket.
[    2.489840] systemd[1]: Mounting Huge Pages File System...
[    2.490530] systemd[1]: Mounting POSIX Message Queue File System...
[    2.491188] systemd[1]: Mounting Kernel Debug File System...
[    2.491835] systemd[1]: Mounting Kernel Trace File System...
[    2.493104] systemd[1]: Starting Journal Service...
[    2.494166] systemd[1]: Starting Availability of block devices...
[    2.495113] systemd[1]: Starting KYLIN CONF2 UPDATE DB...
[    2.496105] systemd[1]: Starting Set the console keyboard layout...
[    2.497760] systemd[1]: Starting Create list of static device nodes=20
for the current kernel...
[    2.498573] systemd[1]: Starting Monitoring of LVM2 mirrors,=20
snapshots etc. using dmeventd or progress polling...
[    2.499380] systemd[1]: Starting Load Kernel Module chromeos_pstore...
[    2.499404] systemd[1]: Condition check resulted in Load Kernel=20
Module drm being skipped.
[    2.500385] systemd[1]: Starting Load Kernel Module efi_pstore...
[    2.501398] systemd[1]: Starting Load Kernel Module pstore_blk...
[    2.502160] systemd[1]: Starting Load Kernel Module pstore_zone...
[    2.502927] systemd[1]: Starting Load Kernel Module ramoops...
[    2.503266] systemd[1]: Condition check resulted in Set Up Additional=20
Binary Formats being skipped.
[    2.503295] systemd[1]: Condition check resulted in File System Check=20
on Root Device being skipped.
[    2.504192] pstore: Registered efi as persistent store backend
[    2.504270] systemd[1]: Starting Load Kernel Modules...
[    2.505212] systemd[1]: Starting Remount Root and Kernel File Systems.=
..
[    2.506163] systemd[1]: Starting udev Coldplug all Devices...
[    2.509109] systemd[1]: Mounted Huge Pages File System.
[    2.509288] systemd[1]: Mounted POSIX Message Queue File System.
[    2.509453] systemd[1]: Mounted Kernel Debug File System.
[    2.509611] systemd[1]: Mounted Kernel Trace File System.
[    2.510198] systemd[1]: Finished Availability of block devices.
[    2.510689] systemd[1]: Finished Create list of static device nodes=20
for the current kernel.
[    2.510931] systemd[1]: modprobe@efi_pstore.service: Succeeded.
[    2.511158] EXT4-fs (nvme0n1p3): re-mounted. Opts: (null)
[    2.511247] systemd[1]: Finished Load Kernel Module efi_pstore.
[    2.513414] systemd[1]: modprobe@pstore_blk.service: Succeeded.
[    2.513670] systemd[1]: Finished Load Kernel Module pstore_blk.
[    2.513921] systemd[1]: modprobe@pstore_zone.service: Succeeded.
[    2.514258] systemd[1]: Finished Load Kernel Module pstore_zone.
[    2.514502] systemd[1]: modprobe@ramoops.service: Succeeded.
[    2.514831] systemd[1]: Finished Load Kernel Module ramoops.
[    2.515197] systemd[1]: Finished Remount Root and Kernel File Systems.
[    2.515565] systemd[1]: Condition check resulted in Rebuild Hardware=20
Database being skipped.
[    2.516273] systemd[1]: Starting Load/Save Random Seed...
[    2.517223] lp: driver loaded but no devices found
[    2.517234] systemd[1]: Starting Create System Users...
[    2.521556] ppdev: user-space parallel port driver
[    2.528553] systemd[1]: Finished Create System Users.
[    2.529674] systemd[1]: Starting Create Static Device Nodes in /dev...
[    2.530226] systemd[1]: Finished Load/Save Random Seed.
[    2.537709] systemd[1]: Finished Create Static Device Nodes in /dev.
[    2.558576] systemd[1]: Finished Set the console keyboard layout.
[    2.582988] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0=20
1100 PQ: 0 ANSI: 6
[    2.583270] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.583702] sd 0:0:0:0: [sda] 483709273 512-byte logical blocks: (248=20
GB/231 GiB)
[    2.584124] sd 0:0:0:0: [sda] Write Protect is off
[    2.584125] sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
[    2.584695] sd 0:0:0:0: [sda] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[    2.597511] systemd[1]: Finished Monitoring of LVM2 mirrors,=20
snapshots etc. using dmeventd or progress polling.
[    2.597632] systemd[1]: Reached target Local File Systems (Pre).
[    2.628828] systemd[1]: modprobe@chromeos_pstore.service: Succeeded.
[    2.629072] systemd[1]: Finished Load Kernel Module chromeos_pstore.
[    2.629181] systemd[1]: Condition check resulted in Platform=20
Persistent Storage Archival being skipped.
[    2.631037]  sda: sda1 sda2
[    2.632654] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    2.678092] systemd[1]: Finished Load Kernel Modules.
[    2.678938] systemd[1]: Mounting FUSE Control File System...
[    2.679578] systemd[1]: Mounting Kernel Configuration File System...
[    2.680163] systemd[1]: Starting Init netctl and process protect=20
value to kernel...
[    2.682312] systemd[1]: Starting Apply Kernel Variables...
[    2.687071] systemd[1]: conf2-update-db.service: Succeeded.
[    2.687311] systemd[1]: Finished KYLIN CONF2 UPDATE DB.
[    2.687437] systemd[1]: Mounted FUSE Control File System.
[    2.687531] systemd[1]: Mounted Kernel Configuration File System.
[    2.687595] systemd[1]: Condition check resulted in VMware vmblock=20
fuse mount being skipped.
[    2.689266] systemd[1]: Finished Apply Kernel Variables.
[    2.695579] systemd[1]: Finished Init netctl and process protect=20
value to kernel.
[    2.696486] systemd[1]: Starting udev Kernel Device Manager...
[    2.734845] systemd[1]: Started udev Kernel Device Manager.
[    3.432707] usb 1-1-port3: Cannot enable. Maybe the USB cable is bad?
[    4.544652] usb 1-1-port3: Cannot enable. Maybe the USB cable is bad?
[    4.544871] usb 1-1-port3: attempt power cycle
[    4.672350] usb 1-1.2.4: new high-speed USB device number 6 using=20
xhci_hcd
[    4.822826] usb 1-1.2.4: New USB device found, idVendor=3D2109,=20
idProduct=3D2817, bcdDevice=3D20.14
[    4.822827] usb 1-1.2.4: New USB device strings: Mfr=3D1, Product=3D2,=
=20
SerialNumber=3D3
[    4.822828] usb 1-1.2.4: Product: USB2.0 Hub
[    4.822829] usb 1-1.2.4: Manufacturer: VIA Labs, Inc.
[    4.822830] usb 1-1.2.4: SerialNumber: 000000000
[    4.824997] hub 1-1.2.4:1.0: USB hub found
[    4.825191] hub 1-1.2.4:1.0: 5 ports detected
[    4.919392] usb 2-1.2.4: new SuperSpeed Gen 1 USB device number 5=20
using xhci_hcd
[    4.978789] usb 2-1.2.4: New USB device found, idVendor=3D2109,=20
idProduct=3D0817, bcdDevice=3D20.14
[    4.978791] usb 2-1.2.4: New USB device strings: Mfr=3D1, Product=3D2,=
=20
SerialNumber=3D3
[    4.978793] usb 2-1.2.4: Product: USB3.0 Hub
[    4.978794] usb 2-1.2.4: Manufacturer: VIA Labs, Inc.
[    4.978794] usb 2-1.2.4: SerialNumber: 000000000
[    4.992277] hub 2-1.2.4:1.0: USB hub found
[    4.992652] hub 2-1.2.4:1.0: 4 ports detected
[    5.056348] usb 1-1.2.5: new high-speed USB device number 7 using=20
xhci_hcd
[    5.157735] usb 1-1.2.5: New USB device found, idVendor=3D2109,=20
idProduct=3D3801, bcdDevice=3D 0.01
[    5.157737] usb 1-1.2.5: New USB device strings: Mfr=3D1, Product=3D2,=
=20
SerialNumber=3D3
[    5.157738] usb 1-1.2.5: Product: USB Billboard Device
[    5.157739] usb 1-1.2.5: Manufacturer: VIA Labs, Inc.
[    5.157740] usb 1-1.2.5: SerialNumber: 0000000000000001
[    5.576352] usb 1-1.2.4.1: new full-speed USB device number 8 using=20
xhci_hcd
[    5.896059] usb 1-1.2.4.1: New USB device found, idVendor=3D0572,=20
idProduct=3D00e5, bcdDevice=3D 0.02
[    5.896061] usb 1-1.2.4.1: New USB device strings: Mfr=3D1, Product=3D=
2,=20
SerialNumber=3D3
[    5.896062] usb 1-1.2.4.1: Product: Targus DOCK221
[    5.896063] usb 1-1.2.4.1: Manufacturer: Synaptics
[    5.896063] usb 1-1.2.4.1: SerialNumber: 000000000000
[    6.844739] usb 1-1-port3: Cannot enable. Maybe the USB cable is bad?
[    7.956689] usb 1-1-port3: Cannot enable. Maybe the USB cable is bad?
[    7.956912] usb 1-1-port3: unable to enumerate USB device
[    8.006342] systemd[1]: Finished udev Coldplug all Devices.
[    8.010000] systemd[1]: Starting Helper to synchronize boot up for=20
ifupdown...
[    8.011821] systemd[1]: Starting Show Plymouth Boot Screen...
[    8.024218] systemd[1]: Finished Helper to synchronize boot up for=20
ifupdown.
[    8.032213] systemd[1]: Created slice system-systemd\x2dbacklight.slic=
e.
[    8.033318] systemd[1]: Starting Load/Save Screen Backlight=20
Brightness of backlight:panel_backlight...
[    8.039244] systemd[1]: Starting Load Kernel Module chromeos_pstore...
[    8.039283] systemd[1]: Condition check resulted in Load Kernel=20
Module efi_pstore being skipped.
[    8.040367] usb 1-1.2.4.5: new high-speed USB device number 11 using=20
xhci_hcd
[    8.040897] systemd[1]: Starting Load Kernel Module pstore_blk...
[    8.042347] systemd[1]: Starting Load Kernel Module pstore_zone...
[    8.042387] systemd[1]: Condition check resulted in Load Kernel=20
Module ramoops being skipped.
[    8.042517] systemd[1]: Condition check resulted in Set Up Additional=20
Binary Formats being skipped.
[    8.042551] systemd[1]: Condition check resulted in File System Check=20
on Root Device being skipped.
[    8.042601] systemd[1]: Condition check resulted in Rebuild Hardware=20
Database being skipped.
[    8.043347] systemd[1]: Finished Load/Save Screen Backlight=20
Brightness of backlight:panel_backlight.
[    8.044247] systemd[1]: modprobe@pstore_blk.service: Succeeded.
[    8.044696] systemd[1]: Finished Load Kernel Module pstore_blk.
[    8.045596] systemd[1]: modprobe@pstore_zone.service: Succeeded.
[    8.046163] systemd[1]: Finished Load Kernel Module pstore_zone.
[    8.054148] piix4_smbus 0000:00:0b.0: SMBus Host Controller at 0xb00,=20
revision 0
[    8.054151] piix4_smbus 0000:00:0b.0: Using register 0x02 for SMBus=20
port selection
[    8.069132] systemd[1]: Found device CUBEX EP2000GE 1024GB DATA.
[    8.073873] systemd[1]: Found device CUBEX EP2000GE 1024GB ESP.
[    8.079451] systemd[1]: Found device CUBEX EP2000GE 1024GB SWAP.
[    8.088752] systemd[1]: Found device CUBEX EP2000GE 1024GB SYSBOOT.
[    8.100979] systemd[1]: Activating swap=20
/dev/disk/by-uuid/0f053111-bb39-491e-a173-f534050f8dfd...
[    8.101084] systemd[1]: Reached target Local File Systems.
[    8.102300] systemd[1]: Starting Set console font and keymap...
[    8.103424] systemd[1]: Starting Create final runtime dir for=20
shutdown pivot root...
[    8.104509] systemd[1]: Starting Raise network interfaces...
[    8.105603] systemd[1]: Starting Tell Plymouth To Write Out Runtime=20
Data...
[    8.105664] systemd[1]: Condition check resulted in Store a System=20
Token in an EFI Variable being skipped.
[    8.105712] systemd[1]: Condition check resulted in Commit a=20
transient machine-id on disk being skipped.
[    8.112905] snd_hda_codec_conexant hdaudioC1D0: SN6180: BIOS=20
auto-probing. V0.1.0.0.
[    8.114539] systemd[1]: Finished Set console font and keymap.
[    8.114597] snd_hda_codec_conexant hdaudioC1D0: autoconfig for=20
SN6180: line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    8.114600] snd_hda_codec_conexant hdaudioC1D0:    speaker_outs=3D0=20
(0x0/0x0/0x0/0x0/0x0)
[    8.114603] snd_hda_codec_conexant hdaudioC1D0:    hp_outs=3D1=20
(0x16/0x0/0x0/0x0/0x0)
[    8.114605] snd_hda_codec_conexant hdaudioC1D0:    mono: mono_out=3D0x=
0
[    8.114606] snd_hda_codec_conexant hdaudioC1D0:    inputs:
[    8.114609] snd_hda_codec_conexant hdaudioC1D0:      Internal Mic=3D0x=
1a
[    8.114611] snd_hda_codec_conexant hdaudioC1D0:      Mic=3D0x19
[    8.115206] systemd[1]: Finished Create final runtime dir for=20
shutdown pivot root.
[    8.115663] systemd[1]: Listening on Load/Save RF Kill Switch Status=20
/dev/rfkill Watch.
[    8.117212] snd_hda_codec_conexant hdaudioC1D0: conexant: hp plugged=3D=
0.
[    8.117215] snd_hda_codec_conexant hdaudioC1D0: Enable sync_write for=20
stable communication
[    8.117216] snd_hda_codec_conexant hdaudioC1D0: conexant:=20
patch_conexant_auto, exit.
[    8.126933] input: HDA Hygon Mic as=20
/devices/pci0000:00/0000:00:08.1/0000:4a:00.6/sound/card1/input13
[    8.127068] input: HDA Hygon Headphone as=20
/devices/pci0000:00/0000:00:08.1/0000:4a:00.6/sound/card1/input14
[    8.136005] systemd[1]: Condition check resulted in Load Kernel=20
Module efi_pstore being skipped.
[    8.141483] usb 1-1.2.4.5: New USB device found, idVendor=3D2109,=20
idProduct=3D3802, bcdDevice=3D 0.01
[    8.141486] usb 1-1.2.4.5: New USB device strings: Mfr=3D1, Product=3D=
2,=20
SerialNumber=3D3
[    8.141489] usb 1-1.2.4.5: Product: USB Billboard Device
[    8.141490] usb 1-1.2.4.5: Manufacturer: VIA Labs, Inc.
[    8.141492] usb 1-1.2.4.5: SerialNumber: 0000000000000001
[    8.142447] systemd[1]: Starting Load Kernel Module pstore_blk...
[    8.143745] systemd[1]: Starting Load Kernel Module pstore_zone...
[    8.143782] systemd[1]: Condition check resulted in Load Kernel=20
Module ramoops being skipped.
[    8.143887] systemd[1]: Condition check resulted in Set Up Additional=20
Binary Formats being skipped.
[    8.143924] systemd[1]: Condition check resulted in Store a System=20
Token in an EFI Variable being skipped.
[    8.143972] systemd[1]: Condition check resulted in Rebuild Hardware=20
Database being skipped.
[    8.144011] systemd[1]: Condition check resulted in Commit a=20
transient machine-id on disk being skipped.
[    8.157814] systemd[1]: modprobe@pstore_zone.service: Succeeded.
[    8.158299] systemd[1]: Finished Load Kernel Module pstore_zone.
[    8.158626] systemd[1]: modprobe@pstore_blk.service: Succeeded.
[    8.158981] systemd[1]: Finished Load Kernel Module pstore_blk.
[    8.161133] systemd[1]: plymouth-start.service: Succeeded.
[    8.161645] systemd[1]: Started Show Plymouth Boot Screen.
[    8.161798] systemd[1]: Condition check resulted in Dispatch Password=20
Requests to Console Directory Watch being skipped.
[    8.161949] systemd[1]: Started Forward Password Requests to Plymouth=20
Directory Watch.
[    8.161983] systemd[1]: Reached target Local Encrypted Volumes.
[    8.165655] systemd[1]: Started Journal Service.
[    8.168512] Adding 9458684k swap on /dev/nvme0n1p6.  Priority:-2=20
extents:1 across:9458684k SSFS
[    8.328071] kvm: Nested Virtualization enabled
[    8.328087] kvm: Nested Paging enabled
[    8.328088] SVM: Virtual VMLOAD VMSAVE supported
[    8.330715] MCE: In-kernel MCE decoding enabled.
[    8.333036] EDAC amd64: F18h_M10h detected (node 0).
[    8.333072] EDAC MC: UMC0 chip selects:
[    8.333074] EDAC amd64: MC: 0:  2048MB 1:     0MB
[    8.333075] EDAC amd64: MC: 2:     0MB 3:     0MB
[    8.333076] EDAC amd64: using x4 syndromes.
[    8.333081] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.333082] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[    8.378552] usb 7-6: Found UVC 1.50 device Integrated Camera (2ef4:207=
b)
[    8.400959] Bluetooth: Core ver 2.22
[    8.400975] NET: Registered protocol family 31
[    8.400975] Bluetooth: HCI device and connection manager initialized
[    8.400978] Bluetooth: HCI socket layer initialized
[    8.400980] Bluetooth: L2CAP socket layer initialized
[    8.400982] Bluetooth: SCO socket layer initialized
[    8.407827] usbcore: registered new interface driver btusb
[    8.412027] usbcore: registered new interface driver rtk_btusb
[    8.414594] Bluetooth: hci0: RTL: examining hci_ver=3D0b hci_rev=3D000=
b=20
lmp_ver=3D0b lmp_subver=3D8852
[    8.416579] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[    8.416581] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[    8.417895] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[    8.418023] Bluetooth: hci0: RTL: cfg_sz 14, total sz 58011
[    8.423964] input: Integrated Camera: Integrated C as=20
/devices/pci0000:00/0000:00:08.1/0000:4a:00.2/usb7/7-6/7-6:1.0/input/inpu=
t15
[    8.426741] usb 7-6: Found UVC 1.50 device Integrated Camera (2ef4:207=
b)
[    8.441548] input: Integrated Camera: Integrated I as=20
/devices/pci0000:00/0000:00:08.1/0000:4a:00.2/usb7/7-6/7-6:1.2/input/inpu=
t16
[    8.441604] usbcore: registered new interface driver uvcvideo
[    8.449757] input: Synaptics Targus DOCK221 as=20
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:01.0/0000:17:00.0/0=
000:18:02.0/0000:19:00.0/usb1/1-1/1-1.2/1-1.2.4/1-1.2.4.1/1-1.2.4.1:1.3/0=
003:0572:00E5.0002/input/input17
[    8.464926] EDAC amd64: F18h_M10h detected (node 0).
[    8.464957] EDAC MC: UMC0 chip selects:
[    8.464958] EDAC amd64: MC: 0:  2048MB 1:     0MB
[    8.464959] EDAC amd64: MC: 2:     0MB 3:     0MB
[    8.464960] EDAC amd64: using x4 syndromes.
[    8.464964] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.464964] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[    8.508449] hid-generic 0003:0572:00E5.0002: input,hidraw1: USB HID=20
v1.11 Device [Synaptics Targus DOCK221] on usb-0000:19:00.0-1.2.4.1/input=
3
[    8.508482] usbcore: registered new interface driver usbhid
[    8.508483] usbhid: USB HID core driver
[    8.553384] usbcore: registered new interface driver snd-usb-audio
[    8.604913] EDAC amd64: F18h_M10h detected (node 0).
[    8.604951] EDAC MC: UMC0 chip selects:
[    8.604953] EDAC amd64: MC: 0:  2048MB 1:     0MB
[    8.604954] EDAC amd64: MC: 2:     0MB 3:     0MB
[    8.604955] EDAC amd64: using x4 syndromes.
[    8.604959] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.604960] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[    8.647850] With USB4 patch v1.0.0
[    8.647860] ACPI: bus type thunderbolt registered
[    8.664660] [7] nhi_probe:1326: thunderbolt 0000:2c:00.0: total paths:=
 21
[    8.665209] [7] tb_ring_alloc:586: thunderbolt 0000:2c:00.0:=20
allocating TX ring 0 of size 10
[    8.665243] [7] tb_ring_alloc:586: thunderbolt 0000:2c:00.0:=20
allocating RX ring 0 of size 10
[    8.665267] [7] tb_ctl_alloc:665: thunderbolt 0000:2c:00.0: control=20
channel created
[    8.665272] [7] icm_probe:2549: thunderbolt 0000:2c:00.0: ICM not=20
supported on this controller
[    8.665285] [7] tb_ring_free:840: thunderbolt 0000:2c:00.0: freeing=20
RX ring 0
[    8.665294] [7] tb_ring_free:840: thunderbolt 0000:2c:00.0: freeing=20
TX ring 0
[    8.665308] [7] tb_ring_alloc:586: thunderbolt 0000:2c:00.0:=20
allocating TX ring 0 of size 10
[    8.665322] [7] tb_ring_alloc:586: thunderbolt 0000:2c:00.0:=20
allocating RX ring 0 of size 10
[    8.665336] [7] tb_ctl_alloc:665: thunderbolt 0000:2c:00.0: control=20
channel created
[    8.665339] [7] tb_probe:2933: thunderbolt 0000:2c:00.0: using=20
software connection manager
[    8.684995] [7] tb_acpi_add_link:89: thunderbolt 0000:2c:00.0:=20
created link from 0000:02:00.0
[    8.685083] [7] tb_acpi_add_link:89: thunderbolt 0000:2c:00.0:=20
created link from 0000:02:01.0
[    8.766749] EDAC amd64: F18h_M10h detected (node 0).
[    8.766782] EDAC MC: UMC0 chip selects:
[    8.766783] EDAC amd64: MC: 0:  2048MB 1:     0MB
[    8.766784] EDAC amd64: MC: 2:     0MB 3:     0MB
[    8.766785] EDAC amd64: using x4 syndromes.
[    8.766789] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.766790] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[    8.805983] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    8.805985] Bluetooth: BNEP filters: protocol multicast
[    8.805990] Bluetooth: BNEP socket layer initialized
[    8.840720] [7] tb_acpi_add_link:89: thunderbolt 0000:2c:00.0:=20
created link from 0000:2b:00.0
[    8.840732] [7] tb_acpi_add_link:89: thunderbolt 0000:2c:00.0:=20
created link from 0000:2b:00.0
[    8.840903] [7] nhi_probe:1365: thunderbolt 0000:2c:00.0: NHI=20
initialized, starting thunderbolt
[    8.840905] [7] tb_ctl_start:708: thunderbolt 0000:2c:00.0: control=20
channel starting...
[    8.840908] [7] tb_ring_start:696: thunderbolt 0000:2c:00.0: starting=20
TX ring 0
[    8.840923] [7] ring_interrupt_active:142: thunderbolt 0000:2c:00.0:=20
enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    8.840926] [7] tb_ring_start:696: thunderbolt 0000:2c:00.0: starting=20
RX ring 0
[    8.840941] [7] ring_interrupt_active:142: thunderbolt 0000:2c:00.0:=20
enabling interrupt at register 0x38200 bit 21 (0x1 -> 0x200001)
[    8.840954] [7] tb_domain_add:459: thunderbolt 0000:2c:00.0: security=20
level set to user
[    8.841983] [7] tb_switch_alloc:2362: thunderbolt 0000:2c:00.0:=20
current switch config:
[    8.841987] [7] tb_dump_switch:1540: thunderbolt 0000:2c:00.0:  USB4=20
Switch: 174c:2428 (Revision: 0, TB Version: 32)
[    8.841989] [7] tb_dump_switch:1543: thunderbolt 0000:2c:00.0:   Max=20
Port Number: 11
[    8.841991] [7] tb_dump_switch:1544: thunderbolt 0000:2c:00.0:   Confi=
g:
[    8.841994] [7] tb_dump_switch:1545: thunderbolt 0000:2c:00.0:=20
Upstream Port Number: 5 Depth: 0 Route String: 0x0 Enabled: 1,=20
PlugEventsDelay: 255ms
[    8.841997] [7] tb_dump_switch:1550: thunderbolt 0000:2c:00.0:=20
unknown1: 0x0 unknown4: 0x0
[    8.847195] [7] tb_switch_configure:2492: thunderbolt 0000:2c:00.0:=20
initializing Switch at 0x0 (depth: 0, up port: 5)
[    8.848408] [7] usb4_switch_credits_init:757: thunderbolt=20
0000:2c:00.0: 0: credit allocation parameters:
[    8.848410] [7] usb4_switch_credits_init:767: thunderbolt=20
0000:2c:00.0: 0:  USB3: 64
[    8.848412] [7] usb4_switch_credits_init:771: thunderbolt=20
0000:2c:00.0: 0:  DP AUX: 2
[    8.848414] [7] usb4_switch_credits_init:775: thunderbolt=20
0000:2c:00.0: 0:  DP main: 0
[    8.848417] [7] usb4_switch_credits_init:779: thunderbolt=20
0000:2c:00.0: 0:  PCIe: 64
[    8.848419] [7] usb4_switch_credits_init:783: thunderbolt=20
0000:2c:00.0: 0:  DMA: 32
[    8.855988] [7] tb_drom_parse:628: thunderbolt 0000:2c:00.0: 0: DROM=20
version: 1
[    8.857122] [7] tb_switch_add:3171: thunderbolt 0000:2c:00.0: 0: uid:=20
0x14547f00174c8a29
[    8.858852] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 1:=20
0:0 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    8.858855] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 27/27
[    8.858857] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 7
[    8.858859] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0xae00000
[    8.858861] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 174/2
[    8.859989] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 2:=20
0:0 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    8.859992] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 27/27
[    8.859994] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 7
[    8.859996] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0xae00000
[    8.859998] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 174/2
[    8.862374] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 3:=20
0:0 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    8.862377] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 27/27
[    8.862379] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 7
[    8.862381] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x4ae00000
[    8.862383] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 174/2
[    8.863511] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 4:=20
0:0 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    8.863514] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 27/27
[    8.863516] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 7
[    8.863519] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x8ae00000
[    8.863521] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 174/2
[    8.863766] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 5:=20
0:0 (Revision: 0, TB Version: 1, Type: NHI (0x2))
[    8.863768] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 20/27
[    8.863770] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 0
[    8.863773] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x0
[    8.863775] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 0/0
[    8.864015] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 6:=20
0:0 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    8.864017] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 8/8
[    8.864020] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 1
[    8.864022] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x0
[    8.864024] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 0/0
[    8.864267] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 7:=20
0:0 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    8.864269] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 8/8
[    8.864271] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 1
[    8.864273] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x0
[    8.864276] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 0/0
[    8.864517] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 8:=20
0:0 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    8.864519] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 8/27
[    8.864521] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 1
[    8.864522] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x0
[    8.864523] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 0/0
[    8.864770] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 9:=20
0:0 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    8.864772] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 8/27
[    8.864774] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 1
[    8.864776] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x0
[    8.864778] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 0/0
[    8.865025] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 10:=20
0:0 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    8.865027] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 9/27
[    8.865030] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 0
[    8.865032] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x0
[    8.865034] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 0/0
[    8.865276] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 11:=20
0:0 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    8.865279] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 9/27
[    8.865281] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 0
[    8.865283] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x0
[    8.865285] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 0/0
[    8.868440] [7] tmu_mode_init:364: thunderbolt 0000:2c:00.0: 0: TMU:=20
supports uni-directional mode
[    8.868579] [7] tb_switch_tmu_init:433: thunderbolt 0000:2c:00.0: 0:=20
TMU: current mode: bi-directional, HiFi
[    8.873920] [7] tb_switch_nvm_add:374: thunderbolt 0000:2c:00.0: 0:=20
NVM version 200012.250409
[    8.874000] [7] tb_switch_tmu_configure:1056: thunderbolt=20
0000:2c:00.0: 0: TMU: mode change bi-directional, HiFi ->=20
uni-directional, LowRes requested
[    8.874444] [7] tb_switch_tmu_enable:1006: thunderbolt 0000:2c:00.0:=20
0: TMU: mode set to: uni-directional, LowRes
[    8.874823] [7] tb_wait_for_port:525: thunderbolt 0000:2c:00.0: 0:1:=20
is unplugged (state: 7)
[    8.874949] [7] tb_wait_for_port:533: thunderbolt 0000:2c:00.0: 0:3:=20
is connected, link is up (state: 2)
[    8.877373] [7] tb_retimer_nvm_authenticate_status:196: thunderbolt=20
0000:2c:00.0: 0:3: reading NVM authentication status of retimers
[    8.940379] Generic FE-GE Realtek PHY r8169-4700:00: attached PHY=20
driver [Generic FE-GE Realtek PHY] (mii_bus:phy_addr=3Dr8169-4700:00,=20
irq=3DIGNORE)
[    8.940865] EDAC amd64: F18h_M10h detected (node 0).
[    8.940901] EDAC MC: UMC0 chip selects:
[    8.940902] EDAC amd64: MC: 0:  2048MB 1:     0MB
[    8.940903] EDAC amd64: MC: 2:     0MB 3:     0MB
[    8.940905] EDAC amd64: using x4 syndromes.
[    8.940909] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.940910] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[    9.143038] usbcore: registered new interface driver r8152
[    9.147172] usbcore: registered new interface driver cdc_ether
[    9.154591] Bluetooth: hci0: RTL: fw version 0xdbc6b20f
[    9.232713] usb 2-1.1: reset SuperSpeedPlus Gen 2 USB device number 3=20
using xhci_hcd
[    9.253362] r8169 0000:47:00.0 enp71s0: Link is Down
[    9.273341] EDAC amd64: F18h_M10h detected (node 0).
[    9.273374] EDAC MC: UMC0 chip selects:
[    9.273375] EDAC amd64: MC: 0:  2048MB 1:     0MB
[    9.273376] EDAC amd64: MC: 2:     0MB 3:     0MB
[    9.273377] EDAC amd64: using x4 syndromes.
[    9.273380] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.273381] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[    9.293829] r8152 2-1.1:1.0 eth0: v1.10.11
[    9.298524] NET: Registered protocol family 38
[    9.303028] r8152 2-1.1:1.0 enx4c56df200810: renamed from eth0
[    9.322374] Bluetooth: RFCOMM TTY layer initialized
[    9.322381] Bluetooth: RFCOMM socket layer initialized
[    9.322389] Bluetooth: RFCOMM ver 1.11
[    9.588663] [7] tb_retimer_unset_inbound_sbtx:236: thunderbolt=20
0000:2c:00.0: 0:3: disabling sideband transactions
[    9.625104] EDAC amd64: F18h_M10h detected (node 0).
[    9.625143] EDAC MC: UMC0 chip selects:
[    9.625145] EDAC amd64: MC: 0:  2048MB 1:     0MB
[    9.625146] EDAC amd64: MC: 2:     0MB 3:     0MB
[    9.625147] EDAC amd64: using x4 syndromes.
[    9.625152] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.625154] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[    9.860926] EDAC amd64: F18h_M10h detected (node 0).
[    9.860962] EDAC MC: UMC0 chip selects:
[    9.860964] EDAC amd64: MC: 0:  2048MB 1:     0MB
[    9.860965] EDAC amd64: MC: 2:     0MB 3:     0MB
[    9.860966] EDAC amd64: using x4 syndromes.
[    9.860970] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.860971] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[    9.964938] EDAC amd64: F18h_M10h detected (node 0).
[    9.964977] EDAC MC: UMC0 chip selects:
[    9.964979] EDAC amd64: MC: 0:  2048MB 1:     0MB
[    9.964980] EDAC amd64: MC: 2:     0MB 3:     0MB
[    9.964982] EDAC amd64: using x4 syndromes.
[    9.964986] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.964988] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[   10.199152] [7] tb_switch_alloc:2362: thunderbolt 0000:2c:00.0:=20
current switch config:
[   10.199156] [7] tb_dump_switch:1540: thunderbolt 0000:2c:00.0:=20
Thunderbolt 3 Switch: 8086:15ef (Revision: 6, TB Version: 16)
[   10.199158] [7] tb_dump_switch:1543: thunderbolt 0000:2c:00.0:   Max=20
Port Number: 13
[   10.199160] [7] tb_dump_switch:1544: thunderbolt 0000:2c:00.0:   Confi=
g:
[   10.199163] [7] tb_dump_switch:1545: thunderbolt 0000:2c:00.0:=20
Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1,=20
PlugEventsDelay: 254ms
[   10.199166] [7] tb_dump_switch:1550: thunderbolt 0000:2c:00.0:=20
unknown1: 0x0 unknown4: 0x0
[   10.204204] [7] tb_switch_configure:2492: thunderbolt 0000:2c:00.0:=20
initializing Switch at 0x3 (depth: 1, up port: 1)
[   10.233022] [7] tb_drom_bit_bang:551: thunderbolt 0000:2c:00.0: 3:=20
reading DROM (length: 0x6a)
[   10.260879] bpfilter: Loaded bpfilter_umh pid 3148
[   10.260983] EDAC amd64: F18h_M10h detected (node 0).
[   10.261003] bpfilter: read fail 0
[   10.261015] EDAC MC: UMC0 chip selects:
[   10.261016] EDAC amd64: MC: 0:  2048MB 1:     0MB
[   10.261017] EDAC amd64: MC: 2:     0MB 3:     0MB
[   10.261018] EDAC amd64: using x4 syndromes.
[   10.261022] EDAC amd64: Node 0: DRAM ECC disabled.
[   10.261023] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[   10.270168] FT_K:  3108: AXI fabric coherency (RGX_CR_SOC_AXI): 0xc
[   10.270573] FT_K:  3108: GPU00 Firmware image 'fantgpu/fh2m.fw' loaded
[   10.273563] FT_K:  3108: GPU00 Shader binary image 'fantgpu/fh2m.sh'=20
loaded
[   10.596152] [7] tb_drom_parse:628: thunderbolt 0000:2c:00.0: 3: DROM=20
version: 1
[   10.597271] [7] tb_switch_add:3171: thunderbolt 0000:2c:00.0: 3: uid:=20
0x14251c4d448a600
[   10.599165] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 1:=20
8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   10.599166] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 19/19
[   10.599167] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   10.599169] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x7800000
[   10.599170] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 120/2
[   10.601058] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 2:=20
8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   10.601060] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 19/19
[   10.601060] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   10.601061] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x0
[   10.601062] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 0/2
[   10.602953] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 3:=20
8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   10.602954] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 19/19
[   10.602955] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   10.602956] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x3c00000
[   10.602957] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 60/2
[   10.604847] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 4:=20
8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   10.604848] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 19/19
[   10.604849] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   10.604850] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x3c00000
[   10.604851] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 60/2
[   10.604852] [7] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:5:=20
disabled by eeprom
[   10.604853] [7] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:6:=20
disabled by eeprom
[   10.604854] [7] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:7:=20
disabled by eeprom
[   10.605100] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 8:=20
8086:15ef (Revision: 6, TB Version: 1, Type: PCIe (0x100102))
[   10.605101] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 8/8
[   10.605102] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   10.605103] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   10.605104] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 8/0
[   10.605353] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 9:=20
8086:15ef (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[   10.605354] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 8/8
[   10.605354] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   10.605355] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   10.605356] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 8/0
[   10.605858] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 10:=20
8086:15ef (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   10.605859] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 9/9
[   10.605860] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   10.605861] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   10.605862] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 8/0
[   10.606363] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 11:=20
8086:15ef (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   10.606364] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 9/9
[   10.606365] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   10.606366] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   10.606367] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 8/0
[   10.606615] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 12:=20
8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   10.606616] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 8/8
[   10.606617] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   10.606618] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   10.606619] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 8/0
[   10.606868] [7] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port 13:=20
8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   10.606869] [7] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max hop=20
id (in/out): 8/8
[   10.606870] [7] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   10.606871] [7] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   10.606872] [7] tb_dump_port:456: thunderbolt 0000:2c:00.0:   Credits=20
(total/control): 8/0
[   10.607121] [7] tb_switch_link_init:2777: thunderbolt 0000:2c:00.0:=20
3: current link speed 10.0 Gb/s
[   10.607122] [7] tb_switch_link_init:2778: thunderbolt 0000:2c:00.0:=20
3: current link width symmetric, dual lanes
[   10.608257] [7] tb_switch_clx_init:231: thunderbolt 0000:2c:00.0: 3:=20
CLx: current mode: disabled
[   10.611162] [7] tmu_mode_init:364: thunderbolt 0000:2c:00.0: 3: TMU:=20
supports uni-directional mode
[   10.611415] [7] tb_switch_tmu_init:433: thunderbolt 0000:2c:00.0: 3:=20
TMU: current mode: bi-directional, HiFi
[   10.611451] thunderbolt 0-3: new device found, vendor=3D0x142 device=3D=
0x221
[   10.611452] thunderbolt 0-3: Targus DOCK221
[   10.613027] [7] tb_switch_nvm_add:374: thunderbolt 0000:2c:00.0: 3:=20
NVM version 50.0
[   10.613682] [7] tb_scan_port:1410: thunderbolt 0000:2c:00.0: 3:=20
discovery, not touching CL states
[   10.613774] [7] tb_wait_for_port:525: thunderbolt 0000:2c:00.0: 3:3:=20
is unplugged (state: 7)
[   10.614532] [7] tb_path_discover:169: thunderbolt 0000:2c:00.0:=20
discovering PCIe Up path starting from 0:7
[   10.614659] [7] tb_dump_hop:20: thunderbolt 0000:2c:00.0: 0:7:  In=20
HopID: 8 =3D> Out port: 3 Out HopID: 8
[   10.614660] [7] tb_dump_hop:22: thunderbolt 0000:2c:00.0: 0:7:=20
Weight: 1 Priority: 3 Credits: 0 Drop: 0 PM: 0
[   10.614661] [7] tb_dump_hop:25: thunderbolt 0000:2c:00.0: 0:7:=20
Counter enabled: 0 Counter index: 0
[   10.614663] [7] tb_dump_hop:27: thunderbolt 0000:2c:00.0: 0:7:   Flow=20
Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   10.614664] [7] tb_dump_hop:30: thunderbolt 0000:2c:00.0: 0:7:=20
Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   10.614784] [7] tb_dump_hop:20: thunderbolt 0000:2c:00.0: 3:1:  In=20
HopID: 8 =3D> Out port: 8 Out HopID: 8
[   10.614786] [7] tb_dump_hop:22: thunderbolt 0000:2c:00.0: 3:1:=20
Weight: 1 Priority: 3 Credits: 64 Drop: 0 PM: 0
[   10.614787] [7] tb_dump_hop:25: thunderbolt 0000:2c:00.0: 3:1:=20
Counter enabled: 1 Counter index: 2
[   10.614788] [7] tb_dump_hop:27: thunderbolt 0000:2c:00.0: 3:1:   Flow=20
Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   10.614789] [7] tb_dump_hop:30: thunderbolt 0000:2c:00.0: 3:1:=20
Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   10.614790] [7] tb_path_discover:210: thunderbolt 0000:2c:00.0: path=20
discovery complete
[   10.615289] [7] tb_path_discover:169: thunderbolt 0000:2c:00.0:=20
discovering PCIe Down path starting from 3:8
[   10.615416] [7] tb_dump_hop:20: thunderbolt 0000:2c:00.0: 3:8:  In=20
HopID: 8 =3D> Out port: 1 Out HopID: 8
[   10.615417] [7] tb_dump_hop:22: thunderbolt 0000:2c:00.0: 3:8:=20
Weight: 1 Priority: 3 Credits: 7 Drop: 0 PM: 0
[   10.615418] [7] tb_dump_hop:25: thunderbolt 0000:2c:00.0: 3:8:=20
Counter enabled: 1 Counter index: 1
[   10.615420] [7] tb_dump_hop:27: thunderbolt 0000:2c:00.0: 3:8:   Flow=20
Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   10.615421] [7] tb_dump_hop:30: thunderbolt 0000:2c:00.0: 3:8:=20
Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x1
[   10.615542] [7] tb_dump_hop:20: thunderbolt 0000:2c:00.0: 0:3:  In=20
HopID: 8 =3D> Out port: 7 Out HopID: 8
[   10.615543] [7] tb_dump_hop:22: thunderbolt 0000:2c:00.0: 0:3:=20
Weight: 1 Priority: 3 Credits: 64 Drop: 0 PM: 0
[   10.615544] [7] tb_dump_hop:25: thunderbolt 0000:2c:00.0: 0:3:=20
Counter enabled: 1 Counter index: 2
[   10.615546] [7] tb_dump_hop:27: thunderbolt 0000:2c:00.0: 0:3:   Flow=20
Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   10.615547] [7] tb_dump_hop:30: thunderbolt 0000:2c:00.0: 0:3:=20
Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   10.615548] [7] tb_path_discover:210: thunderbolt 0000:2c:00.0: path=20
discovery complete
[   10.615669] [7] tb_tunnel_discover_pci:332: thunderbolt 0000:2c:00.0:=20
0:7 <-> 3:8 (PCI): discovered
[   10.616932] [7] tb_add_dp_resources:228: thunderbolt 0000:2c:00.0:=20
0:10: DP IN resource available
[   10.617563] [7] tb_add_dp_resources:228: thunderbolt 0000:2c:00.0:=20
0:11: DP IN resource available
[   10.661170] EDAC amd64: F18h_M10h detected (node 0).
[   10.661230] EDAC MC: UMC0 chip selects:
[   10.661231] EDAC amd64: MC: 0:  2048MB 1:     0MB
[   10.661231] EDAC amd64: MC: 2:     0MB 3:     0MB
[   10.661232] EDAC amd64: using x4 syndromes.
[   10.661239] EDAC amd64: Node 0: DRAM ECC disabled.
[   10.661240] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[   10.669286] bpfilter: Loaded bpfilter_umh pid 3188
[   10.669425] bpfilter: read fail 0
[   10.876730] EDAC amd64: F18h_M10h detected (node 0).
[   10.876759] EDAC MC: UMC0 chip selects:
[   10.876760] EDAC amd64: MC: 0:  2048MB 1:     0MB
[   10.876761] EDAC amd64: MC: 2:     0MB 3:     0MB
[   10.876762] EDAC amd64: using x4 syndromes.
[   10.876765] EDAC amd64: Node 0: DRAM ECC disabled.
[   10.876766] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[   10.880956] bpfilter: Loaded bpfilter_umh pid 3195
[   10.881052] bpfilter: read fail 0
[   11.016748] EDAC amd64: F18h_M10h detected (node 0).
[   11.016767] bpfilter: Loaded bpfilter_umh pid 3205
[   11.016782] EDAC MC: UMC0 chip selects:
[   11.016783] EDAC amd64: MC: 0:  2048MB 1:     0MB
[   11.016784] EDAC amd64: MC: 2:     0MB 3:     0MB
[   11.016785] EDAC amd64: using x4 syndromes.
[   11.016789] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.016790] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[   11.016875] bpfilter: read fail 0
[   11.112948] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[   11.400888] EDAC amd64: F18h_M10h detected (node 0).
[   11.400951] EDAC MC: UMC0 chip selects:
[   11.400952] EDAC amd64: MC: 0:  2048MB 1:     0MB
[   11.400953] EDAC amd64: MC: 2:     0MB 3:     0MB
[   11.400954] EDAC amd64: using x4 syndromes.
[   11.400961] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.400962] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[   11.645029] bpfilter: Loaded bpfilter_umh pid 3241
[   11.645159] bpfilter: read fail 0
[   11.664748] EDAC amd64: F18h_M10h detected (node 0).
[   11.664807] EDAC MC: UMC0 chip selects:
[   11.664808] EDAC amd64: MC: 0:  2048MB 1:     0MB
[   11.664809] EDAC amd64: MC: 2:     0MB 3:     0MB
[   11.664809] EDAC amd64: using x4 syndromes.
[   11.664817] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.664817] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[   11.888710] EDAC amd64: F18h_M10h detected (node 0).
[   11.888768] EDAC MC: UMC0 chip selects:
[   11.888769] EDAC amd64: MC: 0:  2048MB 1:     0MB
[   11.888770] EDAC amd64: MC: 2:     0MB 3:     0MB
[   11.888770] EDAC amd64: using x4 syndromes.
[   11.888778] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.888779] EDAC amd64: ECC disabled in the BIOS or no ECC=20
capability, module will not load.
                 Either enable ECC checking or force module loading by=20
setting 'ecc_enable_override'.
                 (Note that use of the override may cause unknown side=20
effects.)
[   11.888889] bpfilter: Loaded bpfilter_umh pid 3244
[   11.888998] bpfilter: read fail 0
[   12.194802] bpfilter: Loaded bpfilter_umh pid 3287
[   12.194954] bpfilter: read fail 0
[   12.467052] bpfilter: Loaded bpfilter_umh pid 3349
[   12.467162] bpfilter: read fail 0
[   12.697935] IPv6: ADDRCONF(NETDEV_CHANGE): enx4c56df200810: link=20
becomes ready
[   12.698124] r8152 2-1.1:1.0 enx4c56df200810: carrier on
[   12.816779] bpfilter: Loaded bpfilter_umh pid 3360
[   12.816877] bpfilter: read fail 0
[   13.134792] bpfilter: Loaded bpfilter_umh pid 3388
[   13.134903] bpfilter: read fail 0
[   13.312709] bpfilter: Loaded bpfilter_umh pid 3411
[   13.312815] bpfilter: read fail 0
[   13.414611] bpfilter: Loaded bpfilter_umh pid 3417
[   13.414711] bpfilter: read fail 0
[   13.513072] bpfilter: Loaded bpfilter_umh pid 3421
[   13.513182] bpfilter: read fail 0
[   13.568354] i2c_designware HYGO0010:02: controller timed out, slave=20
addr: 0x2c
[   13.662683] bpfilter: Loaded bpfilter_umh pid 3442
[   13.662776] bpfilter: read fail 0
[   13.780799] bpfilter: Loaded bpfilter_umh pid 3472
[   13.780940] bpfilter: read fail 0
[   13.878687] bpfilter: Loaded bpfilter_umh pid 3484
[   13.878838] bpfilter: read fail 0
[   13.944453] bpfilter: Loaded bpfilter_umh pid 3488
[   13.944602] bpfilter: read fail 0
[   14.054724] bpfilter: Loaded bpfilter_umh pid 3505
[   14.054824] bpfilter: read fail 0
[   14.144384] bpfilter: Loaded bpfilter_umh pid 3509
[   14.144481] bpfilter: read fail 0
[   14.214427] bpfilter: Loaded bpfilter_umh pid 3512
[   14.214518] bpfilter: read fail 0
[   14.296560] bpfilter: Loaded bpfilter_umh pid 3518
[   14.296664] bpfilter: read fail 0
[   14.390274] bpfilter: Loaded bpfilter_umh pid 3520
[   14.390369] bpfilter: read fail 0
[   14.480399] bpfilter: Loaded bpfilter_umh pid 3525
[   14.480498] bpfilter: read fail 0
[   14.558478] bpfilter: Loaded bpfilter_umh pid 3527
[   14.558565] bpfilter: read fail 0
[   14.592355] i2c_designware HYGO0010:02: controller timed out, slave=20
addr: 0x2c
[   14.672934] bpfilter: Loaded bpfilter_umh pid 3562
[   14.673036] bpfilter: read fail 0
[   14.842663] bpfilter: Loaded bpfilter_umh pid 3660
[   14.842758] bpfilter: read fail 0
[   14.957030] bpfilter: Loaded bpfilter_umh pid 3676
[   14.957142] bpfilter: read fail 0
[   15.082887] bpfilter: Loaded bpfilter_umh pid 3686
[   15.083003] bpfilter: read fail 0
[   15.184872] bpfilter: Loaded bpfilter_umh pid 3698
[   15.184970] bpfilter: read fail 0
[   15.311336] bpfilter: Loaded bpfilter_umh pid 3751
[   15.311517] bpfilter: read fail 0
[   15.476966] bpfilter: Loaded bpfilter_umh pid 3815
[   15.477074] bpfilter: read fail 0
[   15.587023] bpfilter: Loaded bpfilter_umh pid 3877
[   15.587138] bpfilter: read fail 0
[   15.697918] bpfilter: Loaded bpfilter_umh pid 3908
[   15.698056] bpfilter: read fail 0
[   15.818836] bpfilter: Loaded bpfilter_umh pid 3958
[   15.818935] bpfilter: read fail 0
[   15.956023] bpfilter: Loaded bpfilter_umh pid 3988
[   15.956119] bpfilter: read fail 0
[   16.079654] bpfilter: Loaded bpfilter_umh pid 4012
[   16.079752] bpfilter: read fail 0
[   16.261208] bpfilter: Loaded bpfilter_umh pid 4175
[   16.261381] bpfilter: read fail 0
[   16.516601] bpfilter: Loaded bpfilter_umh pid 4392
[   16.516796] bpfilter: read fail 0
[   16.702091] bpfilter: Loaded bpfilter_umh pid 4535
[   16.702308] bpfilter: read fail 0
[   16.899290] bpfilter: Loaded bpfilter_umh pid 4627
[   16.899831] bpfilter: read fail 0
[   17.041197] bpfilter: Loaded bpfilter_umh pid 4681
[   17.041305] bpfilter: read fail 0
[   17.146766] bpfilter: Loaded bpfilter_umh pid 4749
[   17.146869] bpfilter: read fail 0
[   17.260997] bpfilter: Loaded bpfilter_umh pid 4778
[   17.261099] bpfilter: read fail 0
[   17.370826] bpfilter: Loaded bpfilter_umh pid 4790
[   17.370929] bpfilter: read fail 0
[   17.473432] bpfilter: Loaded bpfilter_umh pid 4819
[   17.473556] bpfilter: read fail 0
[   17.570838] bpfilter: Loaded bpfilter_umh pid 4827
[   17.570944] bpfilter: read fail 0
[   17.692547] bpfilter: Loaded bpfilter_umh pid 4855
[   17.692642] bpfilter: read fail 0
[   17.798658] bpfilter: Loaded bpfilter_umh pid 4861
[   17.798754] bpfilter: read fail 0
[   17.885707] bpfilter: Loaded bpfilter_umh pid 4869
[   17.885803] bpfilter: read fail 0
[   18.062608] bpfilter: Loaded bpfilter_umh pid 4879
[   18.062715] bpfilter: read fail 0
[   18.173185] bpfilter: Loaded bpfilter_umh pid 4884
[   18.173284] bpfilter: read fail 0
[   18.334708] bpfilter: Loaded bpfilter_umh pid 4887
[   18.334811] bpfilter: read fail 0
[   18.485224] bpfilter: Loaded bpfilter_umh pid 4894
[   18.485317] bpfilter: read fail 0
[   18.619073] bpfilter: Loaded bpfilter_umh pid 4899
[   18.619178] bpfilter: read fail 0
[   18.772894] bpfilter: Loaded bpfilter_umh pid 4903
[   18.772994] bpfilter: read fail 0
[   18.846553] bpfilter: Loaded bpfilter_umh pid 4906
[   18.846651] bpfilter: read fail 0
[   18.944354] i2c_designware HYGO0010:02: controller timed out, slave=20
addr: 0x3c
[   18.947332] bpfilter: Loaded bpfilter_umh pid 4918
[   18.947517] bpfilter: read fail 0
[   19.150726] bpfilter: Loaded bpfilter_umh pid 4975
[   19.150827] bpfilter: read fail 0
[   19.278736] bpfilter: Loaded bpfilter_umh pid 4988
[   19.278836] bpfilter: read fail 0
[   19.420692] bpfilter: Loaded bpfilter_umh pid 4990
[   19.420830] bpfilter: read fail 0
[   19.594746] bpfilter: Loaded bpfilter_umh pid 4994
[   19.594873] bpfilter: read fail 0
[   19.762772] bpfilter: Loaded bpfilter_umh pid 4998
[   19.762896] bpfilter: read fail 0
[   19.942927] bpfilter: Loaded bpfilter_umh pid 5042
[   19.943031] bpfilter: read fail 0
[   20.079242] bpfilter: Loaded bpfilter_umh pid 5067
[   20.079365] bpfilter: read fail 0
[   20.227100] bpfilter: Loaded bpfilter_umh pid 5105
[   20.227223] bpfilter: read fail 0
[   20.349722] bpfilter: Loaded bpfilter_umh pid 5113
[   20.349843] bpfilter: read fail 0
[   20.442878] bpfilter: Loaded bpfilter_umh pid 5117
[   20.442999] bpfilter: read fail 0
[   20.570896] bpfilter: Loaded bpfilter_umh pid 5120
[   20.571024] bpfilter: read fail 0
[   20.674754] bpfilter: Loaded bpfilter_umh pid 5123
[   20.674876] bpfilter: read fail 0
[   20.794824] bpfilter: Loaded bpfilter_umh pid 5126
[   20.794947] bpfilter: read fail 0
[   20.902922] bpfilter: Loaded bpfilter_umh pid 5129
[   20.903043] bpfilter: read fail 0
[   20.994737] bpfilter: Loaded bpfilter_umh pid 5134
[   20.994842] bpfilter: read fail 0
[   21.155098] bpfilter: Loaded bpfilter_umh pid 5168
[   21.155211] bpfilter: read fail 0
[   21.270799] bpfilter: Loaded bpfilter_umh pid 5274
[   21.270906] bpfilter: read fail 0
[   21.374772] bpfilter: Loaded bpfilter_umh pid 5288
[   21.374871] bpfilter: read fail 0
[   21.490660] bpfilter: Loaded bpfilter_umh pid 5297
[   21.490755] bpfilter: read fail 0
[   21.563179] bpfilter: Loaded bpfilter_umh pid 5300
[   21.563309] bpfilter: read fail 0
[   21.685071] bpfilter: Loaded bpfilter_umh pid 5306
[   21.685180] bpfilter: read fail 0
[   21.782837] bpfilter: Loaded bpfilter_umh pid 5308
[   21.782957] bpfilter: read fail 0
[   21.892664] bpfilter: Loaded bpfilter_umh pid 5314
[   21.892784] bpfilter: read fail 0
[   22.018687] bpfilter: Loaded bpfilter_umh pid 5321
[   22.018807] bpfilter: read fail 0
[   22.100747] bpfilter: Loaded bpfilter_umh pid 5327
[   22.100865] bpfilter: read fail 0
[   22.206712] bpfilter: Loaded bpfilter_umh pid 5329
[   22.206828] bpfilter: read fail 0
[   22.294973] bpfilter: Loaded bpfilter_umh pid 5356
[   22.295085] bpfilter: read fail 0
[   22.442864] bpfilter: Loaded bpfilter_umh pid 5387
[   22.442970] bpfilter: read fail 0
[   22.554877] bpfilter: Loaded bpfilter_umh pid 5389
[   22.554992] bpfilter: read fail 0
[   22.638707] bpfilter: Loaded bpfilter_umh pid 5393
[   22.638822] bpfilter: read fail 0
[   22.739808] bpfilter: Loaded bpfilter_umh pid 5395
[   22.739905] bpfilter: read fail 0
[   22.870725] bpfilter: Loaded bpfilter_umh pid 5398
[   22.870824] bpfilter: read fail 0
[   22.946884] bpfilter: Loaded bpfilter_umh pid 5403
[   22.946978] bpfilter: read fail 0
[   23.050819] bpfilter: Loaded bpfilter_umh pid 5425
[   23.050924] bpfilter: read fail 0
[   23.136068] bpfilter: Loaded bpfilter_umh pid 5437
[   23.136185] bpfilter: read fail 0
[   23.242725] bpfilter: Loaded bpfilter_umh pid 5509
[   23.242840] bpfilter: read fail 0
[   23.329125] bpfilter: Loaded bpfilter_umh pid 5524
[   23.329222] bpfilter: read fail 0
[   23.417828] bpfilter: Loaded bpfilter_umh pid 5556
[   23.417923] bpfilter: read fail 0
[   23.522794] bpfilter: Loaded bpfilter_umh pid 5580
[   23.522895] bpfilter: read fail 0
[   23.617393] bpfilter: Loaded bpfilter_umh pid 5584
[   23.617487] bpfilter: read fail 0
[   23.710751] bpfilter: Loaded bpfilter_umh pid 5587
[   23.710871] bpfilter: read fail 0
[   23.797319] bpfilter: Loaded bpfilter_umh pid 5591
[   23.797419] bpfilter: read fail 0
[   23.902649] bpfilter: Loaded bpfilter_umh pid 5594
[   23.902767] bpfilter: read fail 0
[   23.993427] bpfilter: Loaded bpfilter_umh pid 5599
[   23.993520] bpfilter: read fail 0
[   24.106659] bpfilter: Loaded bpfilter_umh pid 5604
[   24.106759] bpfilter: read fail 0
[   24.202689] bpfilter: Loaded bpfilter_umh pid 5606
[   24.202789] bpfilter: read fail 0
[   24.314926] bpfilter: Loaded bpfilter_umh pid 5609
[   24.315044] bpfilter: read fail 0
[   24.398805] bpfilter: Loaded bpfilter_umh pid 5611
[   24.398904] bpfilter: read fail 0
[   24.490978] bpfilter: Loaded bpfilter_umh pid 5643
[   24.491071] bpfilter: read fail 0
[   24.622842] bpfilter: Loaded bpfilter_umh pid 5666
[   24.622946] bpfilter: read fail 0
[   24.715049] bpfilter: Loaded bpfilter_umh pid 5669
[   24.715168] bpfilter: read fail 0
[   24.786421] bpfilter: Loaded bpfilter_umh pid 5671
[   24.786544] bpfilter: read fail 0
[   24.870386] bpfilter: Loaded bpfilter_umh pid 5674
[   24.870511] bpfilter: read fail 0
[   24.958462] bpfilter: Loaded bpfilter_umh pid 5677
[   24.958588] bpfilter: read fail 0
[   25.042360] bpfilter: Loaded bpfilter_umh pid 5680
[   25.042489] bpfilter: read fail 0
[   25.136717] bpfilter: Loaded bpfilter_umh pid 5693
[   25.136838] bpfilter: read fail 0
[   25.242410] bpfilter: Loaded bpfilter_umh pid 5696
[   25.242535] bpfilter: read fail 0
[   25.328555] bpfilter: Loaded bpfilter_umh pid 5700
[   25.328681] bpfilter: read fail 0
[   25.430413] bpfilter: Loaded bpfilter_umh pid 5702
[   25.430536] bpfilter: read fail 0
[   25.524496] bpfilter: Loaded bpfilter_umh pid 5709
[   25.524587] bpfilter: read fail 0
[   25.626945] bpfilter: Loaded bpfilter_umh pid 5747
[   25.627053] bpfilter: read fail 0
[   25.726839] bpfilter: Loaded bpfilter_umh pid 5762
[   25.726938] bpfilter: read fail 0
[   25.822987] bpfilter: Loaded bpfilter_umh pid 5764
[   25.823095] bpfilter: read fail 0
[   25.920567] bpfilter: Loaded bpfilter_umh pid 5769
[   25.920690] bpfilter: read fail 0
[   26.010714] bpfilter: Loaded bpfilter_umh pid 5772
[   26.010835] bpfilter: read fail 0
[   26.118714] bpfilter: Loaded bpfilter_umh pid 5775
[   26.118839] bpfilter: read fail 0
[   26.226576] bpfilter: Loaded bpfilter_umh pid 5777
[   26.226696] bpfilter: read fail 0
[   26.333026] bpfilter: Loaded bpfilter_umh pid 5782
[   26.333124] bpfilter: read fail 0
[   26.430904] bpfilter: Loaded bpfilter_umh pid 5784
[   26.431000] bpfilter: read fail 0
[   26.530798] bpfilter: Loaded bpfilter_umh pid 5787
[   26.530891] bpfilter: read fail 0
[   26.630637] bpfilter: Loaded bpfilter_umh pid 5796
[   26.630735] bpfilter: read fail 0
[   26.733122] bpfilter: Loaded bpfilter_umh pid 5840
[   26.733247] bpfilter: read fail 0
[   26.866788] bpfilter: Loaded bpfilter_umh pid 5847
[   26.866888] bpfilter: read fail 0
[   26.958893] bpfilter: Loaded bpfilter_umh pid 5850
[   26.959009] bpfilter: read fail 0
[   27.059128] bpfilter: Loaded bpfilter_umh pid 5853
[   27.059228] bpfilter: read fail 0
[   27.145168] bpfilter: Loaded bpfilter_umh pid 5866
[   27.145269] bpfilter: read fail 0
[   27.274788] bpfilter: Loaded bpfilter_umh pid 5869
[   27.274890] bpfilter: read fail 0
[   27.414773] bpfilter: Loaded bpfilter_umh pid 5871
[   27.414891] bpfilter: read fail 0
[   27.506974] bpfilter: Loaded bpfilter_umh pid 5874
[   27.507075] bpfilter: read fail 0
[   27.614744] bpfilter: Loaded bpfilter_umh pid 5876
[   27.614841] bpfilter: read fail 0
[   27.706460] bpfilter: Loaded bpfilter_umh pid 5881
[   27.706552] bpfilter: read fail 0
[   27.810846] bpfilter: Loaded bpfilter_umh pid 5895
[   27.810950] bpfilter: read fail 0
[   27.902605] bpfilter: Loaded bpfilter_umh pid 5900
[   27.902699] bpfilter: read fail 0
[   27.974574] bpfilter: Loaded bpfilter_umh pid 5903
[   27.974667] bpfilter: read fail 0
[   28.034314] bpfilter: Loaded bpfilter_umh pid 5905
[   28.034412] bpfilter: read fail 0
[   28.115149] bpfilter: Loaded bpfilter_umh pid 5911
[   28.115257] bpfilter: read fail 0
[   28.206783] bpfilter: Loaded bpfilter_umh pid 5913
[   28.206881] bpfilter: read fail 0
[   28.302780] bpfilter: Loaded bpfilter_umh pid 5918
[   28.302880] bpfilter: read fail 0
[   28.406613] bpfilter: Loaded bpfilter_umh pid 5932
[   28.406707] bpfilter: read fail 0
[   28.502686] bpfilter: Loaded bpfilter_umh pid 5952
[   28.502780] bpfilter: read fail 0
[   28.617103] bpfilter: Loaded bpfilter_umh pid 5964
[   28.617197] bpfilter: read fail 0
[   28.702614] bpfilter: Loaded bpfilter_umh pid 5968
[   28.702708] bpfilter: read fail 0
[   28.798651] bpfilter: Loaded bpfilter_umh pid 5974
[   28.798778] bpfilter: read fail 0
[   28.886806] bpfilter: Loaded bpfilter_umh pid 5983
[   28.886900] bpfilter: read fail 0
[   28.986825] bpfilter: Loaded bpfilter_umh pid 5986
[   28.986929] bpfilter: read fail 0
[   29.071374] bpfilter: Loaded bpfilter_umh pid 6001
[   29.071377] bpfilter: write fail -32
[   36.721287] PM: suspend entry (deep)
[   36.729228] Filesystems sync: 0.007 seconds
[   36.729434] [fant_vpu_info][vpu_notifier:2319]vpu_notifier: prepare=20
suspend time:36565093428
[   36.756643] Freezing user space processes ... (elapsed 0.002 seconds)=20
done.
[   36.759132] OOM killer disabled.
[   36.759133] Freezing remaining freezable tasks ... (elapsed 0.001=20
seconds) done.
[   36.760390] printk: Suspending console(s) (use no_console_suspend to=20
debug)
[   36.760563] [dfreqgov][fant_devfreq_monitor_suspend:778]suspend done
[   36.804365] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   37.628281] [fant_vpu_info][fantvpu_suspend:2835]fantvpu_suspend:2835
[   37.837900] FT_K:  6027: FantgpuSysDevPrePowerState() state:=20
current=3D1, new=3D0; flags: 0x00000003
[   37.837904] FT_K:  6027: FantgpuSysDevPrePowerState() gpu_local heap=20
stats: total=3D0x1cc00000, used=3D0x1e86000, free=3D0x1ad7a000
[   37.848714] FT_K:  6027: FantgpuSysDevPrePowerState() backup=20
gpu_local heap to sys memory done
[   37.848717] FT_K:  6027: FantgpuSysDevPrePowerState() gpu_inv heap=20
stats: total=3D0xe0000000, used=3D0x2be0000, free=3D0xdd420000
[   37.877434] FT_K:  6027: FantgpuSysDevPrePowerState() backup gpu_inv=20
heap to sys memory done
[   38.109517] ACPI: EC: interrupt blocked
[   38.188561] [308] tb_suspend_noirq:2630: thunderbolt 0000:2c:00.0:=20
suspending...
[   38.188564] [308] tb_switch_suspend:3454: thunderbolt 0000:2c:00.0:=20
0: suspending switch
[   38.188567] [308] tb_switch_suspend:3454: thunderbolt 0000:2c:00.0:=20
3: suspending switch
[   38.188861] [308] tb_switch_set_wake:3340: thunderbolt 0000:2c:00.0:=20
3: enabling wakeup: 0x1c
[   38.190629] [308] tb_switch_set_wake:3340: thunderbolt 0000:2c:00.0:=20
0: enabling wakeup: 0x1c
[   38.192478] [308] tb_suspend_noirq:2634: thunderbolt 0000:2c:00.0:=20
suspend finished
[   38.192480] [308] tb_ring_stop:771: thunderbolt 0000:2c:00.0:=20
stopping RX ring 0
[   38.192484] [308] ring_interrupt_active:142: thunderbolt=20
0000:2c:00.0: disabling interrupt at register 0x38200 bit 21 (0x200001=20
-> 0x1)
[   38.192494] [308] tb_ring_stop:771: thunderbolt 0000:2c:00.0:=20
stopping TX ring 0
[   38.192498] [308] ring_interrupt_active:142: thunderbolt=20
0000:2c:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[   38.192505] [308] tb_ctl_stop:738: thunderbolt 0000:2c:00.0: control=20
channel stopped
[   38.492520] ACPI: Preparing to enter system sleep state S3
[   38.492579] ACPI: EC: event blocked
[   38.492579] ACPI: EC: EC stopped
[   38.492580] PM: Saving platform NVS memory
[   38.492909] Disabling non-boot CPUs ...
[   38.494546] smpboot: CPU 1 is now offline
[   38.498392] smpboot: CPU 2 is now offline
[   38.502626] smpboot: CPU 3 is now offline
[   38.506379] smpboot: CPU 4 is now offline
[   38.509790] smpboot: CPU 5 is now offline
[   38.513655] smpboot: CPU 6 is now offline
[   38.517349] smpboot: CPU 7 is now offline
[   38.521357] smpboot: CPU 8 is now offline
[   38.524150] Spectre V2 : Update user space SMT mitigation: STIBP off
[   38.525530] smpboot: CPU 9 is now offline
[   38.529422] smpboot: CPU 10 is now offline
[   38.533774] smpboot: CPU 11 is now offline
[   38.537469] smpboot: CPU 12 is now offline
[   38.541118] smpboot: CPU 13 is now offline
[   38.545020] smpboot: CPU 14 is now offline
[   38.549240] smpboot: CPU 15 is now offline
[   38.552654] ACPI: Low-level resume complete
[   38.552713] ACPI: EC: EC started
[   38.552713] PM: Restoring platform NVS memory
[   38.553767] Enabling non-boot CPUs ...
[   38.553819] x86: Booting SMP configuration:
[   38.553820] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   38.556493] CPU1 is up
[   38.556510] smpboot: Booting Node 0 Processor 2 APIC 0x4
[   38.558952] CPU2 is up
[   38.558967] smpboot: Booting Node 0 Processor 3 APIC 0x6
[   38.561410] CPU3 is up
[   38.561423] smpboot: Booting Node 0 Processor 4 APIC 0x8
[   38.564035] CPU4 is up
[   38.564051] smpboot: Booting Node 0 Processor 5 APIC 0xa
[   38.566584] CPU5 is up
[   38.566598] smpboot: Booting Node 0 Processor 6 APIC 0xc
[   38.569156] CPU6 is up
[   38.569171] smpboot: Booting Node 0 Processor 7 APIC 0xe
[   38.571740] CPU7 is up
[   38.571756] smpboot: Booting Node 0 Processor 8 APIC 0x1
[   38.574362] Spectre V2 : Update user space SMT mitigation: STIBP=20
always-on
[   38.574367] CPU8 is up
[   38.574399] smpboot: Booting Node 0 Processor 9 APIC 0x3
[   38.576956] CPU9 is up
[   38.576970] smpboot: Booting Node 0 Processor 10 APIC 0x5
[   38.579536] CPU10 is up
[   38.579549] smpboot: Booting Node 0 Processor 11 APIC 0x7
[   38.582138] CPU11 is up
[   38.582150] smpboot: Booting Node 0 Processor 12 APIC 0x9
[   38.584784] CPU12 is up
[   38.584799] smpboot: Booting Node 0 Processor 13 APIC 0xb
[   38.587473] CPU13 is up
[   38.587486] smpboot: Booting Node 0 Processor 14 APIC 0xd
[   38.590188] CPU14 is up
[   38.590204] smpboot: Booting Node 0 Processor 15 APIC 0xf
[   38.592939] CPU15 is up
[   38.595157] ACPI: Waking up from system sleep state S3
[   38.598912] ACPI: EC: interrupt unblocked
[   39.198326] [6343] tb_ctl_start:708: thunderbolt 0000:2c:00.0:=20
control channel starting...
[   39.198328] [6343] tb_ring_start:696: thunderbolt 0000:2c:00.0:=20
starting TX ring 0
[   39.198338] [6343] ring_interrupt_active:142: thunderbolt=20
0000:2c:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[   39.198340] [6343] tb_ring_start:696: thunderbolt 0000:2c:00.0:=20
starting RX ring 0
[   39.198349] [6343] ring_interrupt_active:142: thunderbolt=20
0000:2c:00.0: enabling interrupt at register 0x38200 bit 21 (0x1 ->=20
0x200001)
[   39.198356] [6343] tb_resume_noirq:2678: thunderbolt 0000:2c:00.0:=20
resuming...
[   39.198358] [6343] tb_switch_resume:3354: thunderbolt 0000:2c:00.0:=20
0: resuming switch
[   39.198360] [6343] tb_switch_configure:2492: thunderbolt=20
0000:2c:00.0: restoring Switch at 0x0 (depth: 0, up port: 5)
[   39.198706] [6343] usb4_switch_check_wakes:192: thunderbolt=20
0000:2c:00.0: 0:1: USB4 wake: no, connection wake: no, disconnection=20
wake: no
[   39.198831] [6343] usb4_switch_check_wakes:192: thunderbolt=20
0000:2c:00.0: 0:3: USB4 wake: no, connection wake: no, disconnection=20
wake: no
[   39.198833] [6343] tb_switch_set_wake:3342: thunderbolt 0000:2c:00.0:=20
0: disabling wakeup
[   39.202495] [6343] tmu_mode_init:364: thunderbolt 0000:2c:00.0: 0:=20
TMU: supports uni-directional mode
[   39.202621] [6343] tb_switch_tmu_init:433: thunderbolt 0000:2c:00.0:=20
0: TMU: current mode: off
[   39.202747] [6343] tb_wait_for_port:520: thunderbolt 0000:2c:00.0:=20
0:3: is unplugged (state: 7), retrying...
[   39.310253] [6343] tb_wait_for_port:544: thunderbolt 0000:2c:00.0:=20
0:3: is connected, link is not up (state: 1), retrying...
[   39.418253] [6343] tb_wait_for_port:544: thunderbolt 0000:2c:00.0:=20
0:3: is connected, link is not up (state: 1), retrying...
[   39.526252] [6343] tb_wait_for_port:544: thunderbolt 0000:2c:00.0:=20
0:3: is connected, link is not up (state: 1), retrying...
[   39.598446] [1950] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0:=20
acking hot plug event on 0:3
[   39.599093] [1950] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0:=20
acking hot plug event on 0:4
[   39.601772] [1950] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0:=20
acking hot unplug event on 0:3
[   39.602422] [1950] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0:=20
acking hot plug event on 0:3
[   39.603150] [1950] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0:=20
acking hot unplug event on 0:4
[   39.634253] [6343] tb_wait_for_port:520: thunderbolt 0000:2c:00.0:=20
0:3: is unplugged (state: 7), retrying...
[   39.671426] [1950] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0:=20
acking hot unplug event on 0:3
[   39.742252] [6343] tb_wait_for_port:520: thunderbolt 0000:2c:00.0:=20
0:3: is unplugged (state: 7), retrying...
[   39.850253] [6343] tb_wait_for_port:520: thunderbolt 0000:2c:00.0:=20
0:3: is unplugged (state: 7), retrying...
[   39.958250] [6343] tb_wait_for_port:520: thunderbolt 0000:2c:00.0:=20
0:3: is unplugged (state: 7), retrying...
[   40.066252] [6343] tb_wait_for_port:520: thunderbolt 0000:2c:00.0:=20
0:3: is unplugged (state: 7), retrying...
[   40.174252] [6343] tb_wait_for_port:544: thunderbolt 0000:2c:00.0:=20
0:3: is connected, link is not up (state: 1), retrying...
[   40.239562] [1950] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0:=20
acking hot plug event on 0:3
[   40.243585] [1950] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0:=20
acking hot plug event on 0:4
[   40.282189] thunderbolt 0000:2c:00.0: 0:3: failed to reach state=20
TB_PORT_UP. Ignoring port...
[   40.282190] thunderbolt 0000:2c:00.0: 0:3: lost during suspend,=20
disconnecting
[   40.282194] [6343] tb_tunnel_deactivate:2249: thunderbolt=20
0000:2c:00.0: 0:7 <-> 3:8 (PCI): deactivating
[   40.282284] [6343] tb_path_deactivate:470: thunderbolt 0000:2c:00.0:=20
deactivating PCIe Down path from 3:8 to 0:7
[   40.282410] [6343] tb_path_deactivate:470: thunderbolt 0000:2c:00.0:=20
deactivating PCIe Up path from 0:7 to 3:8
[   40.282631] thunderbolt 0-3: device disconnected
[   40.282692] [6343] tb_switch_tmu_configure:1056: thunderbolt=20
0000:2c:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[   40.283137] [6343] tb_switch_tmu_enable:1006: thunderbolt=20
0000:2c:00.0: 0: TMU: mode set to: bi-directional, HiFi
[   40.284148] [6343] tb_resume_noirq:2722: thunderbolt 0000:2c:00.0:=20
resume finished
[   40.284156] [6348] tb_handle_hotplug:2196: thunderbolt 0000:2c:00.0:=20
0:3: hotplug: scanning
[   40.284274] [6348] tb_wait_for_port:533: thunderbolt 0000:2c:00.0:=20
0:3: is connected, link is up (state: 2)
[   40.286132] [6348] tb_retimer_nvm_authenticate_status:196:=20
thunderbolt 0000:2c:00.0: 0:3: reading NVM authentication status of retim=
ers
[   40.998274] [6348] tb_retimer_unset_inbound_sbtx:236: thunderbolt=20
0000:2c:00.0: 0:3: disabling sideband transactions
[   41.614682] [6348] tb_switch_alloc:2362: thunderbolt 0000:2c:00.0:=20
current switch config:
[   41.614684] [6348] tb_dump_switch:1540: thunderbolt 0000:2c:00.0:=20
Thunderbolt 3 Switch: 8086:15ef (Revision: 6, TB Version: 16)
[   41.614686] [6348] tb_dump_switch:1543: thunderbolt 0000:2c:00.0:=20
Max Port Number: 13
[   41.614687] [6348] tb_dump_switch:1544: thunderbolt 0000:2c:00.0:=20
Config:
[   41.614688] [6348] tb_dump_switch:1545: thunderbolt 0000:2c:00.0:=20
Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0,=20
PlugEventsDelay: 10ms
[   41.614689] [6348] tb_dump_switch:1550: thunderbolt 0000:2c:00.0:=20
unknown1: 0x0 unknown4: 0x0
[   41.619736] [6348] tb_switch_configure:2492: thunderbolt=20
0000:2c:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[   41.622762] [1950] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0:=20
acking hot plug event on 3:2
[   41.638241] [6348] tb_drom_bit_bang:551: thunderbolt 0000:2c:00.0: 3:=20
reading DROM (length: 0x6a)
[   41.983316] [6348] tb_drom_parse:628: thunderbolt 0000:2c:00.0: 3:=20
DROM version: 1
[   41.984327] [6348] tb_switch_add:3171: thunderbolt 0000:2c:00.0: 3:=20
uid: 0x14251c4d448a600
[   41.986221] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
1: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   41.986223] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   41.986224] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   41.986225] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x3c00000
[   41.986226] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 60/2
[   41.988115] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
2: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   41.988116] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   41.988117] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   41.988118] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x3c00000
[   41.988119] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 60/2
[   41.990009] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
3: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   41.990010] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   41.990011] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   41.990012] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x3c00000
[   41.990013] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 60/2
[   41.991905] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
4: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   41.991906] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   41.991907] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   41.991908] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x3c00000
[   41.991909] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 60/2
[   41.991910] [6348] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:5:=20
disabled by eeprom
[   41.991911] [6348] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:6:=20
disabled by eeprom
[   41.991912] [6348] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:7:=20
disabled by eeprom
[   41.992157] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
8: 8086:15ef (Revision: 6, TB Version: 1, Type: PCIe (0x100102))
[   41.992158] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   41.992158] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   41.992159] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   41.992160] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   41.992409] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
9: 8086:15ef (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[   41.992410] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   41.992411] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   41.992412] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   41.992413] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   41.992915] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
10: 8086:15ef (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   41.992916] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 9/9
[   41.992917] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   41.992918] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   41.992919] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   41.993420] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
11: 8086:15ef (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   41.993421] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 9/9
[   41.993422] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   41.993423] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   41.993423] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   41.993672] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
12: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   41.993673] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   41.993674] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   41.993675] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   41.993676] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   41.993925] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
13: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   41.993926] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   41.993927] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   41.993927] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   41.993928] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   41.994177] [6348] tb_switch_link_init:2777: thunderbolt=20
0000:2c:00.0: 3: current link speed 10.0 Gb/s
[   41.994179] [6348] tb_switch_link_init:2778: thunderbolt=20
0000:2c:00.0: 3: current link width symmetric, single lane
[   41.994683] [6348] tb_port_do_update_credits:1244: thunderbolt=20
0000:2c:00.0: 0:4: total credits changed 174 -> 174
[   41.994685] [6348] tb_switch_clx_init:231: thunderbolt 0000:2c:00.0:=20
3: CLx: current mode: disabled
[   41.997588] [6348] tmu_mode_init:364: thunderbolt 0000:2c:00.0: 3:=20
TMU: supports uni-directional mode
[   41.997840] [6348] tb_switch_tmu_init:433: thunderbolt 0000:2c:00.0:=20
3: TMU: current mode: bi-directional, HiFi
[   41.997861] thunderbolt 0-3: parent 0-0 should not be sleeping
[   41.997871] thunderbolt 0-3: new device found, vendor=3D0x142 device=3D=
0x221
[   41.997872] thunderbolt 0-3: Targus DOCK221
[   41.999280] [6348] tb_switch_nvm_add:374: thunderbolt 0000:2c:00.0:=20
3: NVM version 50.0
[   41.999897] [6348] tb_wait_for_port:533: thunderbolt 0000:2c:00.0:=20
0:4: is connected, link is up (state: 2)
[   42.002168] [1950] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0:=20
acking hot unplug event on 3:2
[   42.002694] [1950] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0:=20
acking hot unplug event on 0:4
[   42.003839] [6348] tb_port_do_update_credits:1244: thunderbolt=20
0000:2c:00.0: 0:4: total credits changed 174 -> 174
[   42.003965] [6348] tb_port_do_update_credits:1244: thunderbolt=20
0000:2c:00.0: 3:1: total credits changed 60 -> 120
[   42.004091] [6348] tb_port_do_update_credits:1244: thunderbolt=20
0000:2c:00.0: 3:2: total credits changed 60 -> 0
[   42.004348] [6348] tb_switch_set_link_width:3038: thunderbolt=20
0000:2c:00.0: 3: link width set to symmetric, dual lanes
[   42.005986] [6348] tb_switch_clx_enable:355: thunderbolt=20
0000:2c:00.0: 3:1: CLx: CL0s/CL1 supported
[   42.005987] [6348] tb_switch_clx_enable:357: thunderbolt=20
0000:2c:00.0: 0:3: CLx: CL0s/CL1 not supported
[   42.006111] [6348] tb_wait_for_port:525: thunderbolt 0000:2c:00.0:=20
3:3: is unplugged (state: 7)
[   42.006366] [6348] tb_handle_hotplug:2190: thunderbolt 0000:2c:00.0:=20
0:4: got plug event for connected port, ignoring
[   42.006369] [6348] tb_handle_hotplug:2148: thunderbolt 0000:2c:00.0:=20
0:3: switch unplugged
[   42.006415] thunderbolt 0-3: device disconnected
[   42.006448] [6348] tb_recalc_estimated_bandwidth:1669: thunderbolt=20
0000:2c:00.0: bandwidth consumption changed, re-calculating estimated=20
bandwidth
[   42.006450] [6348] tb_recalc_estimated_bandwidth:1678: thunderbolt=20
0000:2c:00.0: bandwidth re-calculation done
[   42.006451] [6348] tb_tunnel_one_dp:1730: thunderbolt 0000:2c:00.0:=20
looking for DP IN <-> DP OUT pairs:
[   42.006452] [6348] tb_tunnel_one_dp:1752: thunderbolt 0000:2c:00.0:=20
no suitable DP IN adapter available, not tunneling
[   42.006454] [6348] tb_handle_hotplug:2196: thunderbolt 0000:2c:00.0:=20
0:3: hotplug: scanning
[   42.006519] [6348] tb_wait_for_port:533: thunderbolt 0000:2c:00.0:=20
0:3: is connected, link is up (state: 2)
[   42.008182] [6348] tb_retimer_nvm_authenticate_status:196:=20
thunderbolt 0000:2c:00.0: 0:3: reading NVM authentication status of retim=
ers
[   42.322189] pcieport 0000:02:01.0: Data Link Layer Link Active not=20
set in 1000 msec
[   42.322200] pcieport 0000:17:00.0: can't change power state from=20
D3cold to D0 (config space inaccessible)
[   42.326372] pcieport 0000:18:02.0: can't change power state from=20
D3cold to D0 (config space inaccessible)
[   42.326373] pcieport 0000:18:04.0: can't change power state from=20
D3cold to D0 (config space inaccessible)
[   42.718858] [6348] tb_retimer_unset_inbound_sbtx:236: thunderbolt=20
0000:2c:00.0: 0:3: disabling sideband transactions
[   43.329069] [6348] tb_switch_alloc:2362: thunderbolt 0000:2c:00.0:=20
current switch config:
[   43.329071] [6348] tb_dump_switch:1540: thunderbolt 0000:2c:00.0:=20
Thunderbolt 3 Switch: 8086:15ef (Revision: 6, TB Version: 16)
[   43.329072] [6348] tb_dump_switch:1543: thunderbolt 0000:2c:00.0:=20
Max Port Number: 13
[   43.329073] [6348] tb_dump_switch:1544: thunderbolt 0000:2c:00.0:=20
Config:
[   43.329075] [6348] tb_dump_switch:1545: thunderbolt 0000:2c:00.0:=20
Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1,=20
PlugEventsDelay: 255ms
[   43.329076] [6348] tb_dump_switch:1550: thunderbolt 0000:2c:00.0:=20
unknown1: 0x0 unknown4: 0x0
[   43.334123] [6348] tb_switch_configure:2492: thunderbolt=20
0000:2c:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[   43.351931] [6348] tb_drom_bit_bang:551: thunderbolt 0000:2c:00.0: 3:=20
reading DROM (length: 0x6a)
[   43.566193] xhci_hcd 0000:19:00.0: can't change power state from=20
D3cold to D0 (config space inaccessible)
[   43.631066] ACPI: EC: event unblocked
[   43.631383] xhci_hcd 0000:19:00.0: can't change power state from=20
D3hot to D0 (config space inaccessible)
[   43.631409] xhci_hcd 0000:19:00.0: Controller not ready at resume -19
[   43.631410] xhci_hcd 0000:19:00.0: PCI post-resume error -19!
[   43.631411] xhci_hcd 0000:19:00.0: HC died; cleaning up
[   43.631423] PM: dpm_run_callback(): pci_pm_resume+0x0/0xf0 returns -19
[   43.631426] PM: Device 0000:19:00.0 failed to resume async: error -19
[   43.631466] pcieport 0000:18:04.0: pciehp: pcie_do_write_cmd: no=20
response from device
[   43.634932] pcieport 0000:02:01.0: pciehp: Slot(0-1): Card not present
[   43.662753] xhci_hcd 0000:19:00.0: remove, state 4
[   43.663246] usb usb2: USB disconnect, device number 1
[   43.663493] usb 2-1: USB disconnect, device number 2
[   43.663616] usb 2-1.1: USB disconnect, device number 3
[   43.790233] r8169 0000:47:00.0 enp71s0: Link is Down
[   43.804875] usb 2-1.2: USB disconnect, device number 4
[   43.805121] usb 2-1.2.4: USB disconnect, device number 5
[   43.850548] nvme nvme0: Shutdown timeout set to 10 seconds
[   43.851462] nvme nvme0: 8/0/0 default/read/poll queues
[   43.871902] usb 7-6: reset high-speed USB device number 2 using xhci_h=
cd
[   43.883994] usb 5-5: reset full-speed USB device number 2 using xhci_h=
cd
[   43.908306] xhci_hcd 0000:19:00.0: USB bus 2 deregistered
[   43.908923] xhci_hcd 0000:19:00.0: remove, state 4
[   43.909170] usb usb1: USB disconnect, device number 1
[   43.909293] usb 1-1: USB disconnect, device number 2
[   43.909540] usb 1-1.2: USB disconnect, device number 3
[   43.909663] usb 1-1.2.4: USB disconnect, device number 6
[   43.909787] usb 1-1.2.4.1: USB disconnect, device number 8
[   43.988906] usb 1-1.2.4.5: USB disconnect, device number 11
[   44.032233] usb 1-1.2.5: USB disconnect, device number 7
[   44.118664] xhci_hcd 0000:19:00.0: Host halt failed, -19
[   44.118666] xhci_hcd 0000:19:00.0: Host not accessible, reset failed.
[   44.132983] xhci_hcd 0000:19:00.0: USB bus 1 deregistered
[   44.158418] usb 5-6: reset full-speed USB device number 3 using xhci_h=
cd
[   44.165325] pci 0000:19:00.0: Removing from iommu group 16
[   44.170889] pci_bus 0000:19: busn_res: [bus 19] is released
[   44.177801] pci 0000:18:02.0: Removing from iommu group 16
[   44.186562] pci_bus 0000:1a: busn_res: [bus 1a] is released
[   44.192364] pci 0000:18:04.0: Removing from iommu group 16
[   44.194091] pci_bus 0000:18: busn_res: [bus 18-1a] is released
[   44.200019] pci 0000:17:00.0: Removing from iommu group 16
[   44.321217] fant-drv 0000:45:00.0:=20
[chip_g0m_soc][g0m_soc_wait_mcufw_ready:1125]wait mcufw init ready done.=20
wait time: 690115 us, pcie_stat: 0x309, ddr_stat: 0x4, dbg_reserved_6:=20
0x0, ddrc1_value: 0x115343
[   44.321244] fant-drv 0000:45:00.0:=20
[hal][hal_mcufw_status_check:3539]ddr init f_count:0 and=20
paddr:00000333c0d031fa, ddr retrain count:0 and paddr:00000333c0d031f8,=20
pcie_stat: 0x309, ddr_stat: 0x4, dbg_reserved_6: 0x0
[   44.388976] FT_K:  6027: FantgpuSysDevPostPowerState() state:=20
current=3D0, new=3D1; flags=3D0x00000005; buffer null?=3D0
[   44.464410] FT_K:  6027: FantgpuSysDevPostPowerState() restore=20
gpu_inv heap from sys memory done
[   44.483517] FT_K:  6027: FantgpuSysDevPostPowerState() restore=20
gpu_local heap from sys memory done
[   44.509095] [fant_vpu_info][fantvpu_resume:2848]fantvpu_resume:2848
[   44.911664] [6348] tb_drom_parse:628: thunderbolt 0000:2c:00.0: 3:=20
DROM version: 1
[   44.917107] [6348] tb_switch_add:3171: thunderbolt 0000:2c:00.0: 3:=20
uid: 0x14251c4d448a600
[   44.927480] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
1: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   44.927481] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   44.927483] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   44.927484] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x7800000
[   44.927485] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 120/2
[   44.937491] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
2: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   44.937492] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   44.937493] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   44.937494] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x0
[   44.937495] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 0/2
[   44.947750] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
3: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   44.947751] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   44.947752] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   44.947753] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x3c00000
[   44.947754] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 60/2
[   44.957752] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
4: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   44.957753] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   44.957754] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   44.957755] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x3c00000
[   44.957756] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 60/2
[   44.957757] [6348] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:5:=20
disabled by eeprom
[   44.957758] [6348] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:6:=20
disabled by eeprom
[   44.957759] [6348] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:7:=20
disabled by eeprom
[   44.959482] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
8: 8086:15ef (Revision: 6, TB Version: 1, Type: PCIe (0x100102))
[   44.959483] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   44.959484] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   44.959485] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   44.959486] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   44.960839] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
9: 8086:15ef (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[   44.960840] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   44.960841] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   44.960842] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   44.960843] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   44.963681] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
10: 8086:15ef (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   44.963682] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 9/9
[   44.963683] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   44.963684] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   44.963685] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   44.966653] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
11: 8086:15ef (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   44.966654] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 9/9
[   44.966655] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   44.966656] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   44.966657] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   44.968012] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
12: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   44.968013] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   44.968014] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   44.968015] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   44.968015] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   44.969369] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
13: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   44.969370] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   44.969371] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   44.969372] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   44.969373] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   44.970729] [6348] tb_switch_link_init:2777: thunderbolt=20
0000:2c:00.0: 3: current link speed 10.0 Gb/s
[   44.970730] [6348] tb_switch_link_init:2778: thunderbolt=20
0000:2c:00.0: 3: current link width symmetric, dual lanes
[   44.976533] [6348] tb_switch_clx_init:231: thunderbolt 0000:2c:00.0:=20
3: CLx: current mode: disabled
[   44.992471] [6348] tmu_mode_init:364: thunderbolt 0000:2c:00.0: 3:=20
TMU: supports uni-directional mode
[   44.993706] [6348] tb_switch_tmu_init:433: thunderbolt 0000:2c:00.0:=20
3: TMU: current mode: bi-directional, HiFi
[   44.993723] thunderbolt 0-3: parent 0-0 should not be sleeping
[   44.993734] thunderbolt 0-3: new device found, vendor=3D0x142 device=3D=
0x221
[   44.993735] thunderbolt 0-3: Targus DOCK221
[   45.000289] [6348] tb_switch_nvm_add:374: thunderbolt 0000:2c:00.0:=20
3: NVM version 50.0
[   45.008807] [6348] tb_switch_clx_enable:355: thunderbolt=20
0000:2c:00.0: 3:1: CLx: CL0s/CL1 supported
[   45.008808] [6348] tb_switch_clx_enable:357: thunderbolt=20
0000:2c:00.0: 0:3: CLx: CL0s/CL1 not supported
[   45.009546] [6348] tb_wait_for_port:525: thunderbolt 0000:2c:00.0:=20
3:3: is unplugged (state: 7)
[   45.010784] [6348] tb_handle_hotplug:2186: thunderbolt 0000:2c:00.0:=20
0:4: got unplug event for disconnected port, ignoring
[   45.010786] [6348] tb_handle_hotplug:2148: thunderbolt 0000:2c:00.0:=20
0:3: switch unplugged
[   45.010831] thunderbolt 0-3: device disconnected
[   45.010866] [6348] tb_recalc_estimated_bandwidth:1669: thunderbolt=20
0000:2c:00.0: bandwidth consumption changed, re-calculating estimated=20
bandwidth
[   45.010867] [6348] tb_recalc_estimated_bandwidth:1678: thunderbolt=20
0000:2c:00.0: bandwidth re-calculation done
[   45.010868] [6348] tb_tunnel_one_dp:1730: thunderbolt 0000:2c:00.0:=20
looking for DP IN <-> DP OUT pairs:
[   45.010869] [6348] tb_tunnel_one_dp:1752: thunderbolt 0000:2c:00.0:=20
no suitable DP IN adapter available, not tunneling
[   45.010871] [6348] tb_handle_hotplug:2196: thunderbolt 0000:2c:00.0:=20
0:3: hotplug: scanning
[   45.011399] [6348] tb_wait_for_port:533: thunderbolt 0000:2c:00.0:=20
0:3: is connected, link is up (state: 2)
[   45.014744] [6348] tb_retimer_nvm_authenticate_status:196:=20
thunderbolt 0000:2c:00.0: 0:3: reading NVM authentication status of retim=
ers
[   45.114382] [dfreqgov][fant_devfreq_monitor_resume:757]resume done
[   45.733724] [6348] tb_retimer_unset_inbound_sbtx:236: thunderbolt=20
0000:2c:00.0: 0:3: disabling sideband transactions
[   46.357853] [6348] tb_switch_alloc:2362: thunderbolt 0000:2c:00.0:=20
current switch config:
[   46.357855] [6348] tb_dump_switch:1540: thunderbolt 0000:2c:00.0:=20
Thunderbolt 3 Switch: 8086:15ef (Revision: 6, TB Version: 16)
[   46.357856] [6348] tb_dump_switch:1543: thunderbolt 0000:2c:00.0:=20
Max Port Number: 13
[   46.357856] [6348] tb_dump_switch:1544: thunderbolt 0000:2c:00.0:=20
Config:
[   46.357858] [6348] tb_dump_switch:1545: thunderbolt 0000:2c:00.0:=20
Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1,=20
PlugEventsDelay: 255ms
[   46.357859] [6348] tb_dump_switch:1550: thunderbolt 0000:2c:00.0:=20
unknown1: 0x0 unknown4: 0x0
[   46.385164] [6348] tb_switch_configure:2492: thunderbolt=20
0000:2c:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[   46.479797] [6348] tb_drom_bit_bang:551: thunderbolt 0000:2c:00.0: 3:=20
reading DROM (length: 0x6a)
[   48.288651] [6348] tb_drom_parse:628: thunderbolt 0000:2c:00.0: 3:=20
DROM version: 1
[   48.294330] [6348] tb_switch_add:3171: thunderbolt 0000:2c:00.0: 3:=20
uid: 0x14251c4d448a600
[   48.304836] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
1: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   48.304837] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   48.304838] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   48.304839] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x7800000
[   48.304840] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 120/2
[   48.315341] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
2: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   48.315342] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   48.315343] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   48.315344] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x0
[   48.315345] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 0/2
[   48.325957] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
3: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   48.325958] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   48.325959] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   48.325960] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x3c00000
[   48.325961] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 60/2
[   48.336831] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
4: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
[   48.336832] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 19/19
[   48.336833] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 16
[   48.336834] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x3c00000
[   48.336835] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 60/2
[   48.336836] [6348] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:5:=20
disabled by eeprom
[   48.336837] [6348] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:6:=20
disabled by eeprom
[   48.336838] [6348] tb_switch_add:3181: thunderbolt 0000:2c:00.0: 3:7:=20
disabled by eeprom
[   48.338313] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
8: 8086:15ef (Revision: 6, TB Version: 1, Type: PCIe (0x100102))
[   48.338314] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   48.338315] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   48.338316] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   48.338317] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   48.339670] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
9: 8086:15ef (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[   48.339671] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   48.339672] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   48.339673] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   48.339674] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   48.342511] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
10: 8086:15ef (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   48.342512] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 9/9
[   48.342513] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   48.342514] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   48.342515] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   48.345102] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
11: 8086:15ef (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   48.345103] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 9/9
[   48.345104] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   48.345106] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   48.345106] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   48.346708] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
12: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   48.346709] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   48.346710] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   48.346710] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   48.346711] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   48.348076] [6348] tb_dump_port:447: thunderbolt 0000:2c:00.0:  Port=20
13: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   48.348077] [6348] tb_dump_port:452: thunderbolt 0000:2c:00.0:   Max=20
hop id (in/out): 8/8
[   48.348078] [6348] tb_dump_port:454: thunderbolt 0000:2c:00.0:   Max=20
counters: 2
[   48.348079] [6348] tb_dump_port:455: thunderbolt 0000:2c:00.0:   NFC=20
Credits: 0x800000
[   48.348079] [6348] tb_dump_port:456: thunderbolt 0000:2c:00.0:=20
Credits (total/control): 8/0
[   48.349310] [6348] tb_switch_link_init:2777: thunderbolt=20
0000:2c:00.0: 3: current link speed 10.0 Gb/s
[   48.349311] [6348] tb_switch_link_init:2778: thunderbolt=20
0000:2c:00.0: 3: current link width symmetric, dual lanes
[   48.355237] [6348] tb_switch_clx_init:231: thunderbolt 0000:2c:00.0:=20
3: CLx: current mode: disabled
[   48.370807] [6348] tmu_mode_init:364: thunderbolt 0000:2c:00.0: 3:=20
TMU: supports uni-directional mode
[   48.372040] [6348] tb_switch_tmu_init:433: thunderbolt 0000:2c:00.0:=20
3: TMU: current mode: bi-directional, HiFi
[   48.372058] thunderbolt 0-3: new device found, vendor=3D0x142 device=3D=
0x221
[   48.372059] thunderbolt 0-3: Targus DOCK221
[   48.377360] [6348] tb_switch_nvm_add:374: thunderbolt 0000:2c:00.0:=20
3: NVM version 50.0
[   48.385879] [6348] tb_switch_clx_enable:355: thunderbolt=20
0000:2c:00.0: 3:1: CLx: CL0s/CL1 supported
[   48.385880] [6348] tb_switch_clx_enable:357: thunderbolt=20
0000:2c:00.0: 0:3: CLx: CL0s/CL1 not supported
[   48.386742] [6348] tb_wait_for_port:525: thunderbolt 0000:2c:00.0:=20
3:3: is unplugged (state: 7)
[   48.387981] [6348] tb_handle_hotplug:2190: thunderbolt 0000:2c:00.0:=20
0:4: got plug event for connected port, ignoring
[   48.387985] [6348] tb_handle_hotplug:2137: thunderbolt 0000:2c:00.0:=20
hotplug event for upstream port 3:2 (unplug: 0)
[   48.387986] [6348] tb_handle_hotplug:2137: thunderbolt 0000:2c:00.0:=20
hotplug event for upstream port 3:2 (unplug: 1)
[   48.387988] [6348] tb_handle_hotplug:2186: thunderbolt 0000:2c:00.0:=20
0:4: got unplug event for disconnected port, ignoring
[   48.388187] acpi LNXPOWER:11: Turning OFF
[   48.388233] acpi LNXPOWER:10: Turning OFF
[   48.388375] OOM killer enabled.
[   48.388375] Restarting tasks ... done.
[   48.390940] [fant_vpu_info][vpu_notifier:2342]vpu_notifier: prepare=20
resume time:48224754632
[   48.390944] PM: suspend exit
[   48.394923] Bluetooth: hci0: RTL: examining hci_ver=3D0b hci_rev=3D000=
b=20
lmp_ver=3D0b lmp_subver=3D8852
[   48.396924] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[   48.396927] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[   48.396946] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[   48.396968] Bluetooth: hci0: RTL: cfg_sz 14, total sz 58011
[   48.439692] [700] tb_tunnel_restart:2181: thunderbolt 0000:2c:00.0:=20
0:7 <-> 3:8 (PCI): activating
[   48.439696] [700] tb_path_activate:499: thunderbolt 0000:2c:00.0:=20
activating PCIe Down path from 0:7 to 3:8
[   48.440553] [700] tb_path_activate:560: thunderbolt 0000:2c:00.0:=20
3:1: Writing hop 1
[   48.440556] [700] tb_dump_hop:20: thunderbolt 0000:2c:00.0: 3:1:  In=20
HopID: 8 =3D> Out port: 8 Out HopID: 8
[   48.440558] [700] tb_dump_hop:22: thunderbolt 0000:2c:00.0: 3:1:=20
Weight: 1 Priority: 3 Credits: 32 Drop: 0 PM: 0
[   48.440559] [700] tb_dump_hop:25: thunderbolt 0000:2c:00.0: 3:1:=20
Counter enabled: 0 Counter index: 2047
[   48.440560] [700] tb_dump_hop:27: thunderbolt 0000:2c:00.0: 3:1:=20
Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   48.440561] [700] tb_dump_hop:30: thunderbolt 0000:2c:00.0: 3:1:=20
Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   48.442175] [700] tb_path_activate:560: thunderbolt 0000:2c:00.0:=20
0:7: Writing hop 0
[   48.442177] [700] tb_dump_hop:20: thunderbolt 0000:2c:00.0: 0:7:  In=20
HopID: 8 =3D> Out port: 3 Out HopID: 8
[   48.442178] [700] tb_dump_hop:22: thunderbolt 0000:2c:00.0: 0:7:=20
Weight: 1 Priority: 3 Credits: 7 Drop: 0 PM: 0
[   48.442179] [700] tb_dump_hop:25: thunderbolt 0000:2c:00.0: 0:7:=20
Counter enabled: 0 Counter index: 2047
[   48.442181] [700] tb_dump_hop:27: thunderbolt 0000:2c:00.0: 0:7:=20
Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   48.442183] [700] tb_dump_hop:30: thunderbolt 0000:2c:00.0: 0:7:=20
Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   48.443948] [700] tb_path_activate:571: thunderbolt 0000:2c:00.0:=20
path activation complete
[   48.443952] [700] tb_path_activate:499: thunderbolt 0000:2c:00.0:=20
activating PCIe Up path from 3:8 to 0:7
[   48.445204] [700] tb_path_activate:560: thunderbolt 0000:2c:00.0:=20
0:3: Writing hop 1
[   48.445206] [700] tb_dump_hop:20: thunderbolt 0000:2c:00.0: 0:3:  In=20
HopID: 8 =3D> Out port: 7 Out HopID: 8
[   48.445207] [700] tb_dump_hop:22: thunderbolt 0000:2c:00.0: 0:3:=20
Weight: 1 Priority: 3 Credits: 64 Drop: 0 PM: 0
[   48.445209] [700] tb_dump_hop:25: thunderbolt 0000:2c:00.0: 0:3:=20
Counter enabled: 0 Counter index: 2047
[   48.445210] [700] tb_dump_hop:27: thunderbolt 0000:2c:00.0: 0:3:=20
Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   48.445211] [700] tb_dump_hop:30: thunderbolt 0000:2c:00.0: 0:3:=20
Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   48.449303] [700] tb_path_activate:560: thunderbolt 0000:2c:00.0:=20
3:8: Writing hop 0
[   48.449307] [700] tb_dump_hop:20: thunderbolt 0000:2c:00.0: 3:8:  In=20
HopID: 8 =3D> Out port: 1 Out HopID: 8
[   48.449309] [700] tb_dump_hop:22: thunderbolt 0000:2c:00.0: 3:8:=20
Weight: 1 Priority: 3 Credits: 7 Drop: 0 PM: 0
[   48.449312] [700] tb_dump_hop:25: thunderbolt 0000:2c:00.0: 3:8:=20
Counter enabled: 0 Counter index: 2047
[   48.449314] [700] tb_dump_hop:27: thunderbolt 0000:2c:00.0: 3:8:=20
Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   48.449316] [700] tb_dump_hop:30: thunderbolt 0000:2c:00.0: 3:8:=20
Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   48.454157] [700] tb_path_activate:571: thunderbolt 0000:2c:00.0:=20
path activation complete
[   48.484193] [700] tb_lc_xhci_connect:313: thunderbolt 0000:2c:00.0:=20
3:1: xHCI connected
[   48.502935] [700] tb_lc_xhci_connect:313: thunderbolt 0000:2c:00.0:=20
3:3: xHCI connected
[   49.133814] Bluetooth: hci0: RTL: fw version 0xdbc6b20f
[   49.763725] pcieport 0000:02:01.0: pciehp: Slot(0-1): Card present
[   49.763972] pcieport 0000:02:01.0: pciehp: Slot(0-1): Link Up
[   49.901409] pci 0000:17:00.0: [8086:15ef] type 01 class 0x060400
[   49.908994] pci 0000:17:00.0: enabling Extended Tags
[   49.966768] pci 0000:17:00.0: supports D1 D2
[   49.967015] pci 0000:17:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[   49.975473] pci 0000:17:00.0: 2.000 Gb/s available PCIe bandwidth,=20
limited by 2.5 GT/s PCIe x1 link at 0000:02:01.0 (capable of 31.504 Gb/s=20
with 8.0 GT/s PCIe x4 link)
[   49.991490] pci 0000:17:00.0: Adding to iommu group 16
[   50.004278] pcieport 0000:02:01.0: ASPM: current common clock=20
configuration is broken, reconfiguring
[   50.009852] pci 0000:17:00.0: bridge configuration invalid ([bus=20
00-00]), reconfiguring
[   50.023160] pci 0000:18:02.0: [8086:15ef] type 01 class 0x060400
[   50.030023] pci 0000:18:02.0: enabling Extended Tags
[   50.048750] pci 0000:18:02.0: supports D1 D2
[   50.048873] pci 0000:18:02.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[   50.071773] pci 0000:18:02.0: Adding to iommu group 16
[   50.080197] pci 0000:18:04.0: [8086:15ef] type 01 class 0x060400
[   50.087065] pci 0000:18:04.0: enabling Extended Tags
[   50.103572] pci 0000:18:04.0: supports D1 D2
[   50.103818] pci 0000:18:04.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[   50.125212] pci 0000:18:04.0: Adding to iommu group 16
[   50.135275] pci 0000:17:00.0: PCI bridge to [bus 18-2a]
[   50.136143] pci 0000:17:00.0:   bridge window [io  0x0000-0x0fff]
[   50.136515] pci 0000:17:00.0:   bridge window [mem 0x00000000-0x000fff=
ff]
[   50.137137] pci 0000:17:00.0:   bridge window [mem=20
0x00000000-0x000fffff 64bit pref]
[   50.137386] pci 0000:18:02.0: bridge configuration invalid ([bus=20
00-00]), reconfiguring
[   50.138131] pci 0000:18:04.0: bridge configuration invalid ([bus=20
00-00]), reconfiguring
[   50.150825] pci 0000:19:00.0: [8086:15f0] type 00 class 0x0c0330
[   50.153828] pci 0000:19:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[   50.160285] pci 0000:19:00.0: enabling Extended Tags
[   50.174114] pci 0000:19:00.0: supports D1 D2
[   50.174484] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[   50.182505] pci 0000:19:00.0: 2.000 Gb/s available PCIe bandwidth,=20
limited by 2.5 GT/s PCIe x1 link at 0000:02:01.0 (capable of 31.504 Gb/s=20
with 8.0 GT/s PCIe x4 link)
[   50.199294] pci 0000:19:00.0: Adding to iommu group 16
[   50.213756] pci 0000:18:02.0: PCI bridge to [bus 19-2a]
[   50.215296] pci 0000:18:02.0:   bridge window [io  0x0000-0x0fff]
[   50.215802] pci 0000:18:02.0:   bridge window [mem 0x00000000-0x000fff=
ff]
[   50.216557] pci 0000:18:02.0:   bridge window [mem=20
0x00000000-0x000fffff 64bit pref]
[   50.216927] pci_bus 0000:19: busn_res: [bus 19-2a] end is updated to 1=
9
[   50.229643] pci 0000:18:04.0: PCI bridge to [bus 1a-2a]
[   50.230515] pci 0000:18:04.0:   bridge window [io  0x0000-0x0fff]
[   50.231155] pci 0000:18:04.0:   bridge window [mem 0x00000000-0x000fff=
ff]
[   50.232044] pci 0000:18:04.0:   bridge window [mem=20
0x00000000-0x000fffff 64bit pref]
[   50.232291] pci_bus 0000:1a: busn_res: [bus 1a-2a] end is updated to 2=
a
[   50.232663] pci_bus 0000:18: busn_res: [bus 18-2a] end is updated to 2=
a
[   50.233531] pci 0000:18:04.0: bridge window [mem=20
0x00100000-0x001fffff 64bit pref] to [bus 1a-2a] add_size 100000=20
add_align 100000
[   50.233655] pci 0000:18:04.0: bridge window [mem=20
0x00100000-0x001fffff] to [bus 1a-2a] add_size 100000 add_align 100000
[   50.233902] pci 0000:17:00.0: bridge window [mem=20
0x00100000-0x002fffff 64bit pref] to [bus 18-2a] add_size 100000=20
add_align 100000
[   50.234148] pci 0000:17:00.0: bridge window [mem=20
0x00100000-0x002fffff] to [bus 18-2a] add_size 100000 add_align 100000
[   50.235632] pci 0000:17:00.0: BAR 14: assigned [mem=20
0xb0000000-0xb0ffffff]
[   50.235879] pci 0000:17:00.0: BAR 15: assigned [mem=20
0x33380000000-0x3339fffffff 64bit pref]
[   50.236125] pci 0000:17:00.0: BAR 13: assigned [io  0x3000-0x4fff]
[   50.236742] pci 0000:18:02.0: BAR 14: assigned [mem=20
0xb0000000-0xb00fffff]
[   50.236989] pci 0000:18:02.0: BAR 15: assigned [mem=20
0x33380000000-0x333800fffff 64bit pref]
[   50.237236] pci 0000:18:04.0: BAR 14: assigned [mem=20
0xb0100000-0xb0ffffff]
[   50.237359] pci 0000:18:04.0: BAR 15: assigned [mem=20
0x33380100000-0x3339fffffff 64bit pref]
[   50.237483] pci 0000:18:02.0: BAR 13: assigned [io  0x3000-0x3fff]
[   50.237606] pci 0000:18:04.0: BAR 13: assigned [io  0x4000-0x4fff]
[   50.237976] pci 0000:19:00.0: BAR 0: assigned [mem 0xb0000000-0xb000ff=
ff]
[   50.238600] pci 0000:18:02.0: PCI bridge to [bus 19]
[   50.238971] pci 0000:18:02.0:   bridge window [io  0x3000-0x3fff]
[   50.239591] pci 0000:18:02.0:   bridge window [mem 0xb0000000-0xb00fff=
ff]
[   50.239964] pci 0000:18:02.0:   bridge window [mem=20
0x33380000000-0x333800fffff 64bit pref]
[   50.240585] pci 0000:18:04.0: PCI bridge to [bus 1a-2a]
[   50.240833] pci 0000:18:04.0:   bridge window [io  0x4000-0x4fff]
[   50.241329] pci 0000:18:04.0:   bridge window [mem 0xb0100000-0xb0ffff=
ff]
[   50.241703] pci 0000:18:04.0:   bridge window [mem=20
0x33380100000-0x3339fffffff 64bit pref]
[   50.242575] pci 0000:17:00.0: PCI bridge to [bus 18-2a]
[   50.242823] pci 0000:17:00.0:   bridge window [io  0x3000-0x4fff]
[   50.243320] pci 0000:17:00.0:   bridge window [mem 0xb0000000-0xb0ffff=
ff]
[   50.243692] pci 0000:17:00.0:   bridge window [mem=20
0x33380000000-0x3339fffffff 64bit pref]
[   50.244447] pcieport 0000:02:01.0: PCI bridge to [bus 17-2a]
[   50.244693] pcieport 0000:02:01.0:   bridge window [io  0x3000-0x6fff]
[   50.245187] pcieport 0000:02:01.0:   bridge window [mem=20
0xb0000000-0xb0ffffff]
[   50.245557] pcieport 0000:02:01.0:   bridge window [mem=20
0x33380000000-0x3339fffffff 64bit pref]
[   50.278484] pcieport 0000:17:00.0: enabling device (0000 -> 0003)
[   50.357476] pcieport 0000:18:02.0: enabling device (0000 -> 0003)
[   50.492633] pcieport 0000:18:04.0: enabling device (0000 -> 0003)
[   50.524428] pcieport 0000:18:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl-=20
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[   50.552849] pci 0000:19:00.0: enabling device (0000 -> 0002)
[   50.594640] pci 0000:19:00.0: quirk_usb_early_handoff+0x0/0x6b5 took=20
41560 usecs
[   50.627230] xhci_hcd 0000:19:00.0: xHCI Host Controller
[   50.628834] xhci_hcd 0000:19:00.0: new USB bus registered, assigned=20
bus number 1
[   50.648495] xhci_hcd 0000:19:00.0: hcc params 0x200077c1 hci version=20
0x110 quirks 0x0000000200009810
[   50.691789] xhci_hcd 0000:19:00.0: xHCI Host Controller
[   50.692652] xhci_hcd 0000:19:00.0: new USB bus registered, assigned=20
bus number 2
[   50.693146] xhci_hcd 0000:19:00.0: Host supports USB 3.1 Enhanced=20
SuperSpeed
[   50.699254] usb usb1: New USB device found, idVendor=3D1d6b,=20
idProduct=3D0002, bcdDevice=3D 5.04
[   50.699500] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[   50.699624] usb usb1: Product: xHCI Host Controller
[   50.699747] usb usb1: Manufacturer: Linux 5.4.18-151+ xhci-hcd
[   50.699870] usb usb1: SerialNumber: 0000:19:00.0
[   50.723989] hub 1-0:1.0: USB hub found
[   50.724980] hub 1-0:1.0: 2 ports detected
[   50.748153] usb usb2: New USB device found, idVendor=3D1d6b,=20
idProduct=3D0003, bcdDevice=3D 5.04
[   50.748399] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[   50.748523] usb usb2: Product: xHCI Host Controller
[   50.748646] usb usb2: Manufacturer: Linux 5.4.18-151+ xhci-hcd
[   50.748769] usb usb2: SerialNumber: 0000:19:00.0
[   50.764874] hub 2-0:1.0: USB hub found
[   50.765744] hub 2-0:1.0: 2 ports detected
[   51.070196] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[   51.228545] usb 1-1: New USB device found, idVendor=3D2109,=20
idProduct=3D2820, bcdDevice=3D 0.30
[   51.228547] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D0
[   51.228548] usb 1-1: Product: USB2.0 Hub
[   51.228549] usb 1-1: Manufacturer: VIA Labs, Inc.
[   51.229553] hub 1-1:1.0: USB hub found
[   51.229700] hub 1-1:1.0: 4 ports detected
[   51.354310] usb 2-1: new SuperSpeedPlus Gen 2 USB device number 2=20
using xhci_hcd
[   51.380158] usb 2-1: New USB device found, idVendor=3D2109,=20
idProduct=3D0820, bcdDevice=3D 0.30
[   51.380160] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D0
[   51.380161] usb 2-1: Product: USB3.0 Hub
[   51.380161] usb 2-1: Manufacturer: VIA Labs, Inc.
[   51.382291] hub 2-1:1.0: USB hub found
[   51.382466] hub 2-1:1.0: 4 ports detected
[   51.946190] usb 1-1.2: new high-speed USB device number 3 using xhci_h=
cd
[   52.095945] usb 1-1.2: New USB device found, idVendor=3D2109,=20
idProduct=3D2817, bcdDevice=3D20.13
[   52.095947] usb 1-1.2: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D3
[   52.095949] usb 1-1.2: Product: USB2.0 Hub
[   52.095950] usb 1-1.2: Manufacturer: VIA Labs, Inc.
[   52.095950] usb 1-1.2: SerialNumber: 000000000
[   52.097413] hub 1-1.2:1.0: USB hub found
[   52.097569] hub 1-1.2:1.0: 5 ports detected
[   52.178248] usb 2-1.1: new SuperSpeedPlus Gen 2 USB device number 3=20
using xhci_hcd
[   52.198707] usb 2-1.1: New USB device found, idVendor=3D0bda,=20
idProduct=3D8153, bcdDevice=3D31.00
[   52.198708] usb 2-1.1: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D6
[   52.198709] usb 2-1.1: Product: USB 10/100/1000 LAN
[   52.198710] usb 2-1.1: Manufacturer: Realtek
[   52.198711] usb 2-1.1: SerialNumber: 00120010F
[   52.282287] usb 2-1.2: new SuperSpeedPlus Gen 2 USB device number 4=20
using xhci_hcd
[   52.330301] usb 2-1.2: New USB device found, idVendor=3D2109,=20
idProduct=3D0817, bcdDevice=3D20.13
[   52.330303] usb 2-1.2: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D3
[   52.330304] usb 2-1.2: Product: USB3.0 Hub
[   52.330305] usb 2-1.2: Manufacturer: VIA Labs, Inc.
[   52.330306] usb 2-1.2: SerialNumber: 000000000
[   52.332989] hub 2-1.2:1.0: USB hub found
[   52.333156] hub 2-1.2:1.0: 4 ports detected
[   52.406550] usb 2-1.1: reset SuperSpeedPlus Gen 2 USB device number 3=20
using xhci_hcd
[   52.462588] r8152 2-1.1:1.0 eth0: v1.10.11
[   53.542537] usb 1-1-port3: Cannot enable. Maybe the USB cable is bad?
[   54.654542] usb 1-1-port3: Cannot enable. Maybe the USB cable is bad?
[   54.654760] usb 1-1-port3: attempt power cycle
[   54.782190] usb 1-1.2.4: new high-speed USB device number 6 using=20
xhci_hcd
[   54.932623] usb 1-1.2.4: New USB device found, idVendor=3D2109,=20
idProduct=3D2817, bcdDevice=3D20.14
[   54.932625] usb 1-1.2.4: New USB device strings: Mfr=3D1, Product=3D2,=
=20
SerialNumber=3D3
[   54.932627] usb 1-1.2.4: Product: USB2.0 Hub
[   54.932627] usb 1-1.2.4: Manufacturer: VIA Labs, Inc.
[   54.932628] usb 1-1.2.4: SerialNumber: 000000000
[   54.934457] hub 1-1.2.4:1.0: USB hub found
[   54.934646] hub 1-1.2.4:1.0: 5 ports detected
[   55.028383] usb 2-1.2.4: new SuperSpeed Gen 1 USB device number 5=20
using xhci_hcd
[   55.086864] usb 2-1.2.4: New USB device found, idVendor=3D2109,=20
idProduct=3D0817, bcdDevice=3D20.14
[   55.086865] usb 2-1.2.4: New USB device strings: Mfr=3D1, Product=3D2,=
=20
SerialNumber=3D3
[   55.086867] usb 2-1.2.4: Product: USB3.0 Hub
[   55.086868] usb 2-1.2.4: Manufacturer: VIA Labs, Inc.
[   55.086868] usb 2-1.2.4: SerialNumber: 000000000
[   55.100027] hub 2-1.2.4:1.0: USB hub found
[   55.100224] hub 2-1.2.4:1.0: 4 ports detected
[   55.162192] usb 1-1.2.5: new high-speed USB device number 7 using=20
xhci_hcd
[   55.263035] usb 1-1.2.5: New USB device found, idVendor=3D2109,=20
idProduct=3D3801, bcdDevice=3D 0.01
[   55.263037] usb 1-1.2.5: New USB device strings: Mfr=3D1, Product=3D2,=
=20
SerialNumber=3D3
[   55.263038] usb 1-1.2.5: Product: USB Billboard Device
[   55.263039] usb 1-1.2.5: Manufacturer: VIA Labs, Inc.
[   55.263040] usb 1-1.2.5: SerialNumber: 0000000000000001
[   55.658190] usb 1-1.2.4.1: new full-speed USB device number 8 using=20
xhci_hcd
[   55.981875] usb 1-1.2.4.1: New USB device found, idVendor=3D0572,=20
idProduct=3D00e5, bcdDevice=3D 0.02
[   55.981877] usb 1-1.2.4.1: New USB device strings: Mfr=3D1, Product=3D=
2,=20
SerialNumber=3D3
[   55.981878] usb 1-1.2.4.1: Product: Targus DOCK221
[   55.981879] usb 1-1.2.4.1: Manufacturer: Synaptics
[   55.981880] usb 1-1.2.4.1: SerialNumber: 000000000000
[   56.101354] input: Synaptics Targus DOCK221 as=20
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:01.0/0000:17:00.0/0=
000:18:02.0/0000:19:00.0/usb1/1-1/1-1.2/1-1.2.4/1-1.2.4.1/1-1.2.4.1:1.3/0=
003:0572:00E5.0003/input/input18
[   56.158281] hid-generic 0003:0572:00E5.0003: input,hidraw1: USB HID=20
v1.11 Device [Synaptics Targus DOCK221] on usb-0000:19:00.0-1.2.4.1/input=
3
[   56.930433] usb 1-1-port3: Cannot enable. Maybe the USB cable is bad?
[   58.042530] usb 1-1-port3: Cannot enable. Maybe the USB cable is bad?
[   58.042748] usb 1-1-port3: unable to enumerate USB device
[   58.086602] r8152 2-1.1:1.0 enx4c56df200810: renamed from eth0
[   58.122207] usb 1-1.2.4.5: new high-speed USB device number 11 using=20
xhci_hcd
[   58.223070] usb 1-1.2.4.5: New USB device found, idVendor=3D2109,=20
idProduct=3D3802, bcdDevice=3D 0.01
[   58.223072] usb 1-1.2.4.5: New USB device strings: Mfr=3D1, Product=3D=
2,=20
SerialNumber=3D3
[   58.223073] usb 1-1.2.4.5: Product: USB Billboard Device
[   58.223074] usb 1-1.2.4.5: Manufacturer: VIA Labs, Inc.
[   58.223075] usb 1-1.2.4.5: SerialNumber: 0000000000000001
[   58.405909] IPv6: ADDRCONF(NETDEV_CHANGE): enx4c56df200810: link=20
becomes ready
[   58.406102] r8152 2-1.1:1.0 enx4c56df200810: carrier on
[   60.418870] systemd-journald[640]: Received client request to flush=20
runtime journal.
[   68.354715] irq 9: nobody cared (try booting with the "irqpoll" option=
)
[   68.354720] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           OE=20
5.4.18-151+ #231
[   68.354721] Source Version: 462bb3b18baa16e0a72783504bee9712052b9ae5
[   68.354721] Hardware name: Suma=20
    N50/22DD2    , BIOS CSCH051019 08/15/2025
[   68.354722] Call Trace:
[   68.354723]  <IRQ>
[   68.354728]  dump_stack+0x6d/0x8d
[   68.354731]  __report_bad_irq+0x3a/0xaf
[   68.354733]  note_interrupt.cold+0xb/0x5c
[   68.354735]  handle_irq_event+0xaa/0xb1
[   68.354735]  handle_fasteoi_irq+0x7d/0x1c0
[   68.354738]  do_IRQ+0x54/0xe0
[   68.354740]  common_interrupt+0xf/0xf
[   68.354740]  </IRQ>
[   68.354742] RIP: 0010:native_safe_halt+0xe/0x10
[   68.354744] Code: 65 48 8b 14 25 c0 74 01 00 f0 80 4a 02 20 48 8b 12=20
83 e2 08 0f 84 7a ff ff ff eb bc e9 07 00 00 00 0f 00 2d 66 c3 46 00 fb=20
f4 <c3> 90 e9 07 00 00 00 0f 00 2d 56 c3 46 00 f4 c3 90 90 0f 1f 44 00
[   68.354745] RSP: 0018:ffffffff90a03e28 EFLAGS: 00000246 ORIG_RAX:=20
ffffffffffffffcc
[   68.354746] RAX: ffffffff8fd9f280 RBX: ffffffff90a13880 RCX:=20
0000000000000001
[   68.354747] RDX: ffffa027afa2c9c0 RSI: 0000000fe609133b RDI:=20
0000000000000086
[   68.354747] RBP: ffffffff90a03e48 R08: 0000000000000020 R09:=20
0000000fe73a403b
[   68.354748] R10: 00000000fffffffb R11: 0000000000000002 R12:=20
0000000000000000
[   68.354748] R13: 0000000000000000 R14: 0000000000000000 R15:=20
0000000000000000
[   68.354750]  ? __cpuidle_text_start+0x8/0x8
[   68.354753]  ? tick_nohz_idle_stop_tick+0x160/0x290
[   68.354754]  ? default_idle+0x20/0x140
[   68.354757]  arch_cpu_idle+0x15/0x20
[   68.354758]  default_idle_call+0x2c/0x30
[   68.354760]  do_idle+0x1e6/0x260
[   68.354762]  cpu_startup_entry+0x1d/0x20
[   68.354763]  rest_init+0xae/0xb0
[   68.354766]  arch_call_rest_init+0xe/0x1b
[   68.354767]  start_kernel+0x53d/0x55d
[   68.354769]  x86_64_start_reservations+0x24/0x26
[   68.354770]  x86_64_start_kernel+0x8b/0x8e
[   68.354772]  secondary_startup_64_no_verify+0xb8/0xbb
[   68.354773] handlers:
[   68.354778] [<0000000008ee0356>] acpi_irq
[   68.354779] Disabling IRQ #9
[   74.688930] [7] tb_cfg_ack_plug:824: thunderbolt 0000:2c:00.0: acking=20
hot plug event on 3:10
[   74.689762] [6423] tb_dp_resource_available:1908: thunderbolt=20
0000:2c:00.0: 3:10: DP OUT resource available
[   74.689765] [6423] tb_tunnel_one_dp:1730: thunderbolt 0000:2c:00.0:=20
looking for DP IN <-> DP OUT pairs:
[   74.689766] [6423] tb_tunnel_one_dp:1752: thunderbolt 0000:2c:00.0:=20
no suitable DP IN adapter available, not tunneling

