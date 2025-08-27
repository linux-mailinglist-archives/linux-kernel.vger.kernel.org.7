Return-Path: <linux-kernel+bounces-787800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4CBB37B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BDE1B626BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B1931354C;
	Wed, 27 Aug 2025 07:09:00 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222E3101B8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756278539; cv=none; b=dlyvdq9Bx/bavVzztCYngoPg/McJCNZzpPLYri6mrn7apI5CiPzS8cm8o2QfrQDOTri4jIIzJJag6GqqzXW7N01aWZ0VqMAxyol4HTa3Jn40bmNofvS91WvhGaCnGq2hGrNNFXo04GuL+imhoZFXgW7y3ajRD1XK38/ug4q0Gk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756278539; c=relaxed/simple;
	bh=uVSGaXsA4qNZIJ74BwBgzHHfoZzrWDaSTKJcxK0GtTY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IUYzRS32ohPzVHcgCvVBhhX5G3XC00p8vnlFGAenJPzAGljOxA4ng7Tev/Bm065efOz/EnVD3CiPrPzZhz+sb7cIs093ujVKH9mQHAMDc1nV323F2fMsDqeTHgi38POI855+usHbs6ko3MIh27N12sfi6HC2nyK6OO7Lj0DBXHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.104] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowADXaXu4rq5oXgKGDw--.605S2;
	Wed, 27 Aug 2025 15:07:36 +0800 (CST)
Message-ID: <46adb25b-7b73-4824-a9ca-41617a5c4bca@iscas.ac.cn>
Date: Wed, 27 Aug 2025 15:07:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH v2 4/5] riscv: bitops: Use __riscv_has_extension_likely
To: Yury Norov <yury.norov@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Charlie Jenkins <charlie@rivosinc.com>,
 Xiao Wang <xiao.w.wang@intel.com>,
 =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vivian Wang <uwu@dram.page>
References: <20250821-riscv-altn-helper-wip-v2-0-9586fa702f78@iscas.ac.cn>
 <20250821-riscv-altn-helper-wip-v2-4-9586fa702f78@iscas.ac.cn>
 <aKcwtXDJKRf4O_tF@yury> <4dba27c4-e7a5-4ffc-8073-08a83c68e527@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <4dba27c4-e7a5-4ffc-8073-08a83c68e527@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADXaXu4rq5oXgKGDw--.605S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw18Xw13CrW8XryfGFykXwb_yoWruw13pr
	48tr1UJryUJr18Jr1UGr1UtryUJr1UJw1UJr1UGF1UJr1UGr1jqr1UXr1jgr1UJr48Jr1U
	Jr15Jr1UZr1UGrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 8/22/25 01:46, Vivian Wang wrote:

> [...]
>> Can you please share bloat-o-meter report against this patch? Can you
>> also show an example of code generation before and after? Have you
>> tried the 'unlikely()` one? How the output looks?
> Thanks for the tip on bloat-o-meter. I'll take a look tomorrow.

That "tomorrow" took a while.

This is what it looks like, old being v6.17-rc1 and new being this patch
series.

It's not as identical as I had hoped originally, but I had went into
each plus and a few minuses and confirmed that the actual asm goto part
seems to have been recreated as expected. The rest of the differences
appear to be explainable by unpredictable factors in the compiler (GCC
14.3.0 in my case).

For example, bpf_lru_populate seems to have got worse register
allocation. It uses one more callee-saved register. Moreover, RISC-V
compressed instructions has shorter encodings when used with some
registers, so for example sd a1,32(s1) is encodable as 2 bytes, but sd
a1,32(s2) is only encodable as 4 bytes. This appears to explain the +16
in code size.

As far as I can tell, which is basically me staring at objdump and
seeing "yeah looks normal", all of these are caused by random factors
due to changes in how now we write the control structures:

add/remove: 0/0 grow/shrink: 14/24 up/down: 72/-234 (-162)
Function                                     old     new   delta
bpf_lru_populate                             450     466     +16
spi_nor_scan                                3506    3516     +10
wants_mount_setattr                          688     696      +8
regulator_irq_map_event_simple               202     208      +6
idling_boosts_thr_without_issues             198     204      +6
trie_lookup_elem                             704     708      +4
ethnl_set_tsconfig                          1694    1698      +4
dev_xdp_attach                              1142    1146      +4
add_mtd_device                              1468    1472      +4
xhci_count_num_new_endpoints.isra            104     106      +2
rtl_init_one                                4360    4362      +2
queued_read_lock_slowpath                    414     416      +2
osq_lock                                     262     264      +2
cpufreq_dbs_governor_start                   520     522      +2
thaw_super_locked                            622     620      -2
stop_machine_from_inactive_cpu               372     370      -2
objpool_init                                 962     960      -2
memweight                                    168     166      -2
irq_destroy_ipi                              248     246      -2
fat_fill_super                              3408    3406      -2
create_boot_cache                            292     290      -2
snd_soc_dapm_get_volsw                       588     584      -4
ip_rcv_core                                  770     766      -4
ip_mc_check_igmp                             736     732      -4
tmigr_quick_check                            224     218      -6
nvdimm_security_flags                        152     146      -6
inode_switch_wbs_work_fn                    1934    1928      -6
sd_uhs2_power_up                             176     168      -8
mmc_power_up.part                            402     394      -8
__alloc_bucket_spinlocks                     190     182      -8
__clk_hw_register_mux                        624     612     -12
bfq_bfqq_expire                              872     858     -14
perf_prepare_sample                         1810    1794     -16
wq_update_node_max_active                    308     288     -20
blk_mq_num_queues                             94      74     -20
register_pidns_sysctls                       248     226     -22
dw8250_setup_port                           1212    1182     -30
build_sched_domains                         4748    4716     -32
Total: Before=16029885, After=16029723, chg -0.00%

That's all I can figure out. I hope this is satisfactory, to anyone reading.

Vivian "dramforever" Wang


