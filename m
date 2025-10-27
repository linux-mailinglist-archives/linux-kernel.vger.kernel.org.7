Return-Path: <linux-kernel+bounces-870998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A62C9C0C2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 161E04F12E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8AB2E3B0D;
	Mon, 27 Oct 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqdZuUZg"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A92DF3EC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551437; cv=none; b=Qvp1ZIzoEerpSxzuZrhSfcgqBN6Og3MShSgt+zKt2/a/gA+mGbrlIciCX0Sr8Kq01+9PuG2CZf2vC/0WJr/auaNYA2BILrsAEFKMZFD3sBKhyN+XnVbI/ZvmQp4pME5fSVpkITiq9RS9Rlzx0dgAc3kWEWdMF29ZVQKQD/TuOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551437; c=relaxed/simple;
	bh=/jwmXwefYuVt5g0Y0Epkgo9Z4+7yJZXykk5hKxyVvtM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eCG9BPCTZ+oNyLmcKsnADQwEh/Uomts3+uGpEoSwVjc4QdV00ibcUkfyCiyp4cvubxw+vs8uDBAYdPkFOG1AdldL0F4o4ta60IUtz3vjjjfKyOfrW8SWfnq1TXkCNaUSOgpHbTJ6RY0CmfO2M2lpWIDovN+5DPLmANySFT3XsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqdZuUZg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33e0008d3b3so4316313a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761551435; x=1762156235; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lL9UEUoqmiRYcJQsao9G1IZUZRnIk2t+7ZihYCouGo8=;
        b=iqdZuUZgZKC9IbWmpB/+JUisDeQPrSuapqCHLKPm4aqvC4NAlVpI6+BdKDtckGvLER
         c7irjn4GDSYceVECm9FAdQ/iCQ0j9LI6sG7g8BZpz1oiJe2IS0h6/bPE2nL+8sThwalk
         RCyYlNgpuEwkSUqjga0EyBEdTKy7fRmNmemLV59NN+f+atj3sKWfFBxJP+BcmgRcZ1KV
         KHjiwsUiBs/6UiSMTGU5ryz8o/Nr69inznzWwcFutQQ5LS9YuMtYxKt2xvyvNYPX6DnF
         aWnjg8HwCklZgedVvkj7WV9vSNgTRlVljgg35YvPmlWXoa5VCvNGFvH2SBDZTNlAO22u
         rGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761551435; x=1762156235;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lL9UEUoqmiRYcJQsao9G1IZUZRnIk2t+7ZihYCouGo8=;
        b=kUAEjxUk9nPenE/FHix0fSNpQ8EZOVSUJ2K1Ok05Tn7vtPzVrZ6dMsHGBlBvWMp/XQ
         1sGYH31atY0mK9dYLt/JwXFrcx3tU53zCFzacJaY/1yvWzEsiir9D4JBxmfEmQaZWuD8
         aykTsVpb0X2yNbemobmr3u0Q/VtrOmMsOPAlco5NTzSyhmtYN4TIZUPF1Ngj5ECV85QG
         q8Ph63NDC6MzApbWQGBxHQ0xb+q8pd8OvlS8PG5+jpa3VwFxOGvj7AJ86P641kVIThCf
         rrg45FPZnhHmfKxfaCpGa/5Mw2gJ8s4yult7SoO4oBchpH459R32HTbjSJoKr2Pmlzdz
         fIRg==
X-Forwarded-Encrypted: i=1; AJvYcCV6F9K+Gkp3ZVbRYbJcWKpvE3EUcLT18nbNakjVIGIj3s1PGrE20O8+C8V0VcErpRkz7zYAazJQsuunxs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOzwZOw3q6b6w3GJkchG0orG1bLxeqBIgfdtd3OPDPFfqeTQp
	eE4bcmtghmk2KNoi5VTEQaVmeJBPElwjczB+CFCI4g/Tgf7KDYCryr8Xg+hVF+eglGeQA3MzNqj
	fCIHX7Zzs2WN+kmLqOZ2zUw6A9LkCPV8=
X-Gm-Gg: ASbGncsG7I3QU67nr98t6mbW7U99Rbaxxt88kjiVgQUebf/CqF9OAqsV7BtNhPV7sDC
	1Pk9mmIzARYsOnTwftddY2dCHXa6MnWBBaGLJ3DW9ddoL2cIvh7S0E+fBAr52l66TTgJ+Kq1JUn
	Osh+aP7J7Jf3ufh80qaBjDIOOr4E+aCNDMfEPnRW12u3Ct8Ja1hlPP1Z06Wo//eixQKy73oCh+Z
	DEtQ2trf6M91im+PNcAMAhEksd1KbYqfM+8iBebKD9GjoWpOGTEqn0IgAKzCyrzseBJfUIy
X-Google-Smtp-Source: AGHT+IFWANXMpCoRGq3rjZOJNK9jgaddHJwOMXluonQ7m2ZqprbB0qeUi8f3Nofpl+PZeUSFNyJdGBanZ3Kptz0zPqA=
X-Received: by 2002:a17:90b:1646:b0:335:228c:6f1f with SMTP id
 98e67ed59e1d1-33fd65fcd26mr15478409a91.12.1761551434804; Mon, 27 Oct 2025
 00:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: chuang <nashuiliang@gmail.com>
Date: Mon, 27 Oct 2025 15:50:22 +0800
X-Gm-Features: AWmQ_bn40jDBjPEHSmTeXf6xnV5Lwqdo8PJ1bYAxsrXW_NvHYaZ78UlDCYbFT34
Message-ID: <CACueBy7-1dMwPQ4mirrRjsOkKKyLchkBR+7qMVqxjo7Bbr1T=A@mail.gmail.com>
Subject: x86/fpu: Inaccurate AVX-512 Usage Tracking via arch_status
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear FPU/x86 Maintainers,

I am writing to report an issue concerning the accuracy of AVX-512
usage tracking, specifically when querying the information via
'/proc/<pid>/arch_status' on systems supporting the instruction set.

This report references the mechanism introduced by the following
patch: https://lore.kernel.org/all/20190117183822.31333-1-aubrey.li@intel.c=
om/T/#u

I have validated the patch's effect in modern environments supporting
AVX-512 (e.g., Intel Xeon Gold, AMD Zen4) and found that the tracking
mechanism does not accurately reflect the actual AVX-512 instruction
usage by the process.

Test Environment:
- CPU: Intel Xeon Gold (AVX-512 supported)
- Test Program: periodic_wake.c (Verified via objdump to not contain
any AVX-512 instructions.)
- Test Goal: To compare AVX-512 execution status as reported by perf
PMU versus procfs arch_status.

perf PMU:

$ perf stat -e instructions,cycles,fp_arith_inst_retired.512b_packed_double=
,fp_arith_inst_retired.512b_packed_single,fp_arith_inst_retired.8_flops,fp_=
arith_inst_retired2.128bit_packed_bf16,fp_arith_inst_retired2.256bit_packed=
_bf16,fp_arith_inst_retired2.512bit_packed_bf16
./periodic_wake > /dev/null
^C./periodic_wake: Interrupt

 Performance counter stats for './periodic_wake':

         2,329,116      instructions                     #    2.86
insn per cycle              (33.57%)
           814,040      cycles
                         (56.61%)
                 0      fp_arith_inst_retired.512b_packed_double
                                 (9.82%)
     <not counted>      fp_arith_inst_retired.512b_packed_single
                                 (0.00%)
     <not counted>      fp_arith_inst_retired.8_flops
                         (0.00%)
     <not counted>      fp_arith_inst_retired2.128bit_packed_bf16
                                  (0.00%)
     <not counted>      fp_arith_inst_retired2.256bit_packed_bf16
                                  (0.00%)
     <not counted>      fp_arith_inst_retired2.512bit_packed_bf16
                                  (0.00%)

       1.366220977 seconds time elapsed

       0.000000000 seconds user
       0.002253000 seconds sys


procfs arch_status:

$ cat /proc/$(pgrep -f "^./periodic_wake")/arch_status
AVX512_elapsed_ms:      44
$ cat /proc/$(pgrep -f "^./periodic_wake")/arch_status
AVX512_elapsed_ms:      64
$ cat /proc/$(pgrep -f "^./periodic_wake")/arch_status
AVX512_elapsed_ms:      91
$ cat /proc/$(pgrep -f "^./periodic_wake")/arch_status
AVX512_elapsed_ms:      50

Based on the observed behavior and a review of the referenced patch,
my hypothesis is:

On AVX-512 capable systems, the implementation appears to record the
current timestamp into 'task->thread.fpu.avx512_timestamp' upon any
task switch, irrespective of whether the task has actually executed an
AVX-512 instruction.

This continuous updating of the timestamp, even for non-AVX-512 tasks,
results in misleading non-zero values for AVX512_elapsed_ms, rendering
the mechanism ineffective for accurately determining if a task is
actively utilizing AVX-512.

Could you please confirm if this analysis is correct and advise on the
appropriate next steps to resolve this discrepancy?

'periodic_wake.c':

#include <stdio.h>
#include <time.h>
#include <unistd.h>
#include <errno.h>

// Define wakeup interval as 100 milliseconds
#define INTERVAL_MS 100

int main() {
    // Convert milliseconds to nanoseconds
    long interval_ns =3D (long)INTERVAL_MS * 1000000L;

    // timespec struct used for nanosleep
    struct timespec requested;
    struct timespec remaining;

    // Initialize the requested time structure
    requested.tv_sec =3D 0;
    requested.tv_nsec =3D interval_ns;

    printf("C Periodic Wakeup Program started (Interval: %dms,
%.9ldns). Press Ctrl+C to stop.\n",
           INTERVAL_MS, interval_ns);

    long long counter =3D 0;

    while (1) {
        counter++;

        // Print current wakeup information
        printf("Wakeup #%lld: Continuing execution.\n", counter);

        // Use nanosleep for high-precision sleep.
        // If nanosleep is interrupted by a signal (e.g., Ctrl+C), it
returns -1 and stores the remaining time in 'remaining'.
        // To maintain accurate periodicity, we re-sleep for the
remaining time if an interruption occurs.

        remaining.tv_sec =3D requested.tv_sec;
        remaining.tv_nsec =3D requested.tv_nsec;

        int result;

        do {
            // Sleep
            result =3D nanosleep(&remaining, &remaining);

            // Check return value
            if (result =3D=3D -1) {
                if (errno =3D=3D EINTR) {
                    // Interrupted by a signal (e.g., debugger or
Ctrl+C), continue sleeping for remaining time
                    printf("[Interrupted] nanosleep was interrupted by
a signal, sleeping for remaining %.3fms\n",
                           (double)remaining.tv_nsec / 1000000.0);
                    // Loop continues, using the remaining time stored
in 'remaining'
                } else {
                    // Other error, print error and exit
                    perror("nanosleep error");
                    return 1;
                }
            }
        } while (result =3D=3D -1 && errno =3D=3D EINTR);

        // If nanosleep returns 0 successfully, continue to the next
loop iteration
    }

    return 0; // Theoretically unreachable
}


Thank you for your time and assistance.

Best regards,

